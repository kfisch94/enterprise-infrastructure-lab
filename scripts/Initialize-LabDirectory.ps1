# Run on DC01 in elevated Windows PowerShell. Preview with -WhatIf first.
# Creates only lab OUs and empty department groups; no users or privileges.
[CmdletBinding(SupportsShouldProcess)]
param()

$ErrorActionPreference = 'Stop'
Import-Module ActiveDirectory
$directoryServer = 'DC01.corp.fischerlab.test'
$labDomain = Get-ADDomain -Server $directoryServer
if ($labDomain.DNSRoot -ne 'corp.fischerlab.test') {
    throw 'Unexpected domain. This script is restricted to corp.fischerlab.test.'
}
$domainDn = $labDomain.DistinguishedName
$rootDn = "OU=FischerLab,$domainDn"
$departmentNames = @('Accounting', 'Design', 'Engineering', 'IT', 'Sales')
$ouPlan = @([pscustomobject]@{Name='FischerLab'; Parent=$domainDn})
foreach ($containerName in @('Users', 'Groups', 'Workstations', 'Servers')) {
    $ouPlan += [pscustomobject]@{Name=$containerName; Parent=$rootDn}
}
foreach ($departmentName in $departmentNames) {
    $ouPlan += [pscustomobject]@{Name=$departmentName; Parent="OU=Users,$rootDn"}
}

foreach ($plannedOu in $ouPlan) {
    $ouDn = "OU=$($plannedOu.Name),$($plannedOu.Parent)"
    $existingOu = Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$ouDn'" -Server $directoryServer
    if ($existingOu) {
        Write-Output "EXISTS OU: $ouDn"
    } elseif ($PSCmdlet.ShouldProcess($ouDn, 'Create protected organizational unit')) {
        New-ADOrganizationalUnit -Name $plannedOu.Name -Path $plannedOu.Parent -ProtectedFromAccidentalDeletion $true -Server $directoryServer
        Write-Output "CREATED OU: $ouDn"
    }
}

$groupPath = "OU=Groups,$rootDn"
foreach ($departmentName in $departmentNames) {
    $groupName = "GG_${departmentName}_Users"
    $groupDn = "CN=$groupName,$groupPath"
    $existingGroup = Get-ADGroup -Filter "SamAccountName -eq '$groupName'" -Server $directoryServer
    if ($existingGroup) {
        if ($existingGroup.DistinguishedName -ne $groupDn -or $existingGroup.GroupScope -ne 'Global' -or $existingGroup.GroupCategory -ne 'Security') {
            throw "Existing group $groupName has unexpected location or type; review it before continuing."
        }
        Write-Output "EXISTS GROUP: $groupName"
    } elseif ($PSCmdlet.ShouldProcess($groupDn, 'Create department global security group')) {
        New-ADGroup -Name $groupName -SamAccountName $groupName -GroupCategory Security -GroupScope Global -Path $groupPath -Description "Simulated $departmentName employees; no administrative privileges assigned" -Server $directoryServer
        Write-Output "CREATED GROUP: $groupName"
    }
}

if ($WhatIfPreference) {
    Write-Output 'Preview complete. No directory changes made.'
} else {
    Write-Output 'Directory structure ready. Employee import is a separate step.'
}
