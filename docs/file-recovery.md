# FS01 file recovery runbook

## Demonstrated scope

Windows Server Backup on FS01 backed up selected `C:\Shares` files to a separate20GB virtual disk, `E:` labeled LabBackups. The source and target share the VMware host/storage failure domain. This is a one-time file recovery exercise; backup scheduling, off-host protection, system-state and full-server recovery were not demonstrated.

## Backup and original evidence

Windows-Server-Backup feature installation succeeded without restart. Dedicated `C:\Shares\IT\restore-validation.txt` contained `FischerLab controlled file recovery test.` and was41 bytes. Original SHA256 was exported to `C:\LabScripts\restore-validation-hash.csv` before backup. Original ACL inherited SYSTEM and Administrators Full Control plus FISCHERLAB\DL_FS01_IT_Modify Modify.

```powershell
wbadmin start backup -backupTarget:E: -include:C:\Shares -vssCopy
wbadmin get versions -backupTarget:E:
```

The successful selected-files backup catalog identified version `10/07/2026-17:59` and file recovery capability. Use the version returned by the catalog for any future operation; the identifier here records this specific exercise.

## Controlled recovery performed

Only the dedicated test file was removed; Test-Path returned False. No department folder or other employee file was deleted. The following operation recovered that exact file to its original location:

```powershell
wbadmin start recovery -version:10/07/2026-17:59 -itemType:File -items:C:\Shares\IT\restore-validation.txt -backupTarget:E: -machine:FS01 -overwrite:Skip
```

Recovery reported41 bytes,1 file and0 failures. Verification read the content, recomputed SHA256 and compared it with the saved original; comparison returned True. icacls displayed the original inherited permissions.

```powershell
$expected = Import-Csv C:\LabScripts\restore-validation-hash.csv
$restored = Get-FileHash C:\Shares\IT\restore-validation.txt -Algorithm SHA256
"Hash matches original: $($restored.Hash -eq $expected.Hash)"
icacls C:\Shares\IT\restore-validation.txt
```

## Employee access verification

On CLIENT01, ordinary employee sessions ran whoami and read the same restored UNC file:

```powershell
whoami
Get-Content '\\FS01.corp.fischerlab.test\IT\restore-validation.txt' -ErrorAction Stop
```

fischerlab\amelia successfully read the original content; fischerlab\omora received Access denied. This corroborates the department boundary after recovery. No post-restore write/delete test was performed.

See [LAB-010](../tickets/010-file-backup-and-restore.md) and its [evidence](../evidence/010-file-backup-and-restore/README.md).

References: [wbadmin backup](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/wbadmin-start-backup), [wbadmin recovery](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/wbadmin-start-recovery).
