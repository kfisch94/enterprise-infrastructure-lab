# Read-only verification. Paste the entire file into DC01 PowerShell.
$ErrorActionPreference = 'Stop'
Import-Module ActiveDirectory
$verifyServer = 'DC01.corp.fischerlab.test'
$verifyBase = 'OU=Users,OU=FischerLab,DC=corp,DC=fischerlab,DC=test'
$verifyRoster = @(Import-Csv C:\LabScripts\simulated-employees.csv)
$verifyUsers = @(Get-ADUser -Filter * -SearchBase $verifyBase -Server $verifyServer -Properties Department,MemberOf,pwdLastSet)
$verifyResults = foreach ($employee in $verifyRoster) {
    $account = $verifyUsers | Where-Object { $_.SamAccountName -eq $employee.Username }
    $expectedOu = "OU=$($employee.Department),$verifyBase"
    $expectedGroup = Get-ADGroup -Identity "GG_$($employee.Department)_Users" -Server $verifyServer
    $correctOu = $false
    if ($account) {
        $parentOu = $account.DistinguishedName.Substring($account.DistinguishedName.IndexOf(',') + 1)
        $correctOu = $parentOu -eq $expectedOu
    }
    $requiresChange = $account -and ([int64]$account.pwdLastSet -eq 0)
    $newAccountPolicyOk = $employee.Username -in @('amelia','omora') -or $requiresChange
    [pscustomobject]@{
        Username=$employee.Username
        Department=$employee.Department
        Enabled=[bool]($account -and $account.Enabled)
        CorrectOU=[bool]$correctOu
        CorrectDepartment=[bool]($account -and $account.Department -eq $employee.Department)
        GroupMember=[bool]($account -and $expectedGroup.DistinguishedName -in @($account.MemberOf))
        NewAccountPasswordPolicy=[bool]$newAccountPolicyOk
    }
}
$verifyResults | Format-Table -AutoSize
$verifyFailures = @($verifyResults | Where-Object {
    -not $_.Enabled -or -not $_.CorrectOU -or -not $_.CorrectDepartment -or
    -not $_.GroupMember -or -not $_.NewAccountPasswordPolicy
})
$verifyExtras = @($verifyUsers | Where-Object { $_.SamAccountName -notin @($verifyRoster.Username) })
Write-Host "Roster=$($verifyRoster.Count); AD users=$($verifyUsers.Count); failed rows=$($verifyFailures.Count); extra accounts=$($verifyExtras.Count)"
$verifyUsers | Group-Object Department | Sort-Object Name | Select-Object Name,Count | Format-Table -AutoSize
foreach ($department in @('Accounting','Design','Engineering','IT','Sales')) {
    $members = @(Get-ADGroupMember -Identity "GG_${department}_Users" -Server $verifyServer | Where-Object { $_.ObjectClass -eq 'user' })
    Write-Host "GG_${department}_Users direct user members: $($members.Count)"
}
if ($verifyFailures.Count -or $verifyExtras.Count -or $verifyUsers.Count -ne $verifyRoster.Count) {
    throw 'Verification failed. Inspect the mismatches before continuing.'
}
Write-Host 'PASS: all roster accounts enabled, correctly placed, attributed and grouped; new accounts require first-logon password change.'
