# Run this saved file on DC01. Preview with -WhatIf before applying.
# Uses the password-free roster; existing account passwords are never reset.
[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$CsvPath = (Join-Path $PSScriptRoot 'simulated-employees.csv')
)

$ErrorActionPreference = 'Stop'
Import-Module ActiveDirectory
$directoryServer = 'DC01.corp.fischerlab.test'
$domain = Get-ADDomain -Server $directoryServer
if ($domain.DNSRoot -ne 'corp.fischerlab.test') {
    throw 'This script is restricted to corp.fischerlab.test.'
}
$usersDn = "OU=Users,OU=FischerLab,$($domain.DistinguishedName)"
$departments = @('IT', 'Accounting', 'Engineering', 'Design', 'Sales')
$rows = @(Import-Csv -LiteralPath $CsvPath)
if ($rows.Count -eq 0) { throw 'The roster is empty.' }
$columns = @($rows[0].PSObject.Properties.Name)
foreach ($column in @('FirstName', 'LastName', 'Department', 'Username')) {
    if ($column -notin $columns) { throw "Missing CSV column: $column" }
}
if ('Password' -in $columns) { throw 'Use the password-free roster for this import.' }
$seen = @{}
$plan = @()
$groups = @{}
foreach ($department in $departments) {
    $ou = "OU=$department,$usersDn"
    $null = Get-ADOrganizationalUnit -Identity $ou -Server $directoryServer
    $group = Get-ADGroup -Identity "GG_${department}_Users" -Properties Members -Server $directoryServer
    if ($group.GroupScope -ne 'Global' -or $group.GroupCategory -ne 'Security') {
        throw "Unexpected group type: $($group.Name)"
    }
    $groups[$department] = $group
}

# Validate every record and identity before changing any account.
foreach ($row in $rows) {
    foreach ($field in @('FirstName', 'LastName', 'Department', 'Username')) {
        if ([string]::IsNullOrWhiteSpace($row.$field)) { throw "Blank $field in roster." }
        $row.$field = $row.$field.Trim()
    }
    if ($row.Department -notin $departments) { throw "Unknown department: $($row.Department)" }
    if ($row.Username -notmatch '^[a-zA-Z0-9._-]{1,20}$') { throw "Invalid username: $($row.Username)" }
    if ($seen.ContainsKey($row.Username)) { throw "Duplicate username: $($row.Username)" }
    $seen[$row.Username] = $true
    $ou = "OU=$($row.Department),$usersDn"
    $existing = Get-ADUser -LDAPFilter "(sAMAccountName=$($row.Username))" -Properties Department,MemberOf,UserPrincipalName -Server $directoryServer
    if ($existing) {
        $parent = $existing.DistinguishedName.Substring($existing.DistinguishedName.IndexOf(',') + 1)
        if ($parent -ne $ou) { throw "Existing $($row.Username) is outside its expected OU; inspect before importing." }
        if ($existing.UserPrincipalName -ne "$($row.Username)@$($domain.DNSRoot)") {
            throw "Existing $($row.Username) has an unexpected UPN; inspect before importing."
        }
        if (-not $existing.Enabled) { throw "Existing $($row.Username) is disabled; inspect before importing." }
    }
    $group = $groups[$row.Department]
    $needsDepartment = $existing -and $existing.Department -ne $row.Department
    $needsGroup = -not $existing -or $group.DistinguishedName -notin @($existing.MemberOf)
    $action = if (-not $existing) { 'CREATE' } elseif ($needsDepartment -or $needsGroup) { 'UPDATE METADATA/GROUP' } else { 'EXISTS - NO CHANGE' }
    $plan += [pscustomobject]@{
        Row=$row; Existing=$existing; OU=$ou; Group=$group
        NeedsDepartment=$needsDepartment; NeedsGroup=$needsGroup; Action=$action
    }
}
$plan | ForEach-Object {
    [pscustomobject]@{Username=$_.Row.Username; Department=$_.Row.Department; Action=$_.Action}
} | Format-Table -AutoSize | Out-Host
$newCount = @($plan | Where-Object { -not $_.Existing }).Count
Write-Host "Roster: $($rows.Count); new accounts: $newCount; existing accounts: $($rows.Count - $newCount)."
$temporaryPassword = $null
if (-not $WhatIfPreference -and $newCount -gt 0) {
    $temporaryPassword = Read-Host 'Private temporary password for NEW lab accounts (change required at first logon)' -AsSecureString
    if ($temporaryPassword.Length -eq 0) { throw 'Temporary password cannot be empty.' }
}
try {
    foreach ($item in $plan) {
        $row = $item.Row
        if ($item.Action -eq 'EXISTS - NO CHANGE') {
            Write-Host "EXISTS: $($row.Username) - no changes"
            continue
        }
        if (-not $PSCmdlet.ShouldProcess($row.Username, $item.Action)) { continue }
        $account = $item.Existing
        if (-not $account) {
            $parameters = @{
                Name="$($row.FirstName) $($row.LastName)"
                GivenName=$row.FirstName; Surname=$row.LastName
                DisplayName="$($row.FirstName) $($row.LastName)"
                SamAccountName=$row.Username
                UserPrincipalName="$($row.Username)@$($domain.DNSRoot)"
                Department=$row.Department; Path=$item.OU
                AccountPassword=$temporaryPassword; Enabled=$true
                ChangePasswordAtLogon=$true; Server=$directoryServer; PassThru=$true
            }
            $account = New-ADUser @parameters
            Write-Host "CREATED: $($row.Username)"
        } elseif ($item.NeedsDepartment) {
            Set-ADUser -Identity $account.DistinguishedName -Department $row.Department -Server $directoryServer
            Write-Host "DEPARTMENT UPDATED: $($row.Username)"
        }
        if ($item.NeedsGroup) {
            Add-ADGroupMember -Identity $item.Group.DistinguishedName -Members $account.DistinguishedName -Server $directoryServer
            Write-Host "GROUP ADDED: $($row.Username) -> $($item.Group.Name)"
        }
    }
} finally {
    if ($temporaryPassword) { $temporaryPassword.Dispose() }
}
if ($WhatIfPreference) {
    Write-Host 'Preview complete. No account, department or group changes applied.'
} else {
    Write-Host 'Import processing finished. Verify account totals, OU placement and membership before declaring completion.'
}
