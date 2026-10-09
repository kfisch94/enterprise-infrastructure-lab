# LAB-010 — File backup and restore exercise

**Owner:** Kyle Fischer\
**Opened:** October7,2026\
**Status:** Complete for one-time file backup and controlled restore; hash, ACL and employee access verified

## Request

Demonstrate backup and recovery of simulated department data on FS01. Choose a destination after observing disk layout/capacity. Perform a controlled recovery exercise with a dedicated test file, preserving existing department files and access controls.

## Plan

1. Inspect FS01 disks, volume letters, filesystem and free capacity without changing storage.
2. Select and document a backup target and backup method. State whether the target shares the host/storage failure domain; a second virtual disk alone does not establish independent disaster recovery.
3. Create a dedicated recovery-test file and record its contents/hash.
4. Back up department files/configuration with a documented scope and verify the backup.
5. Perform a controlled restore of the test file, verify hash/content and employee access boundaries.
6. Preserve commands, screenshots and limitations. Never claim successful restore from a backup-success message alone.

## Next checkpoint

E07 verifies whoami fischerlab\omora and explicit Get-Content access denied for the restored IT file. E08 verifies whoami fischerlab\amelia and successful read of original test content from the same UNC path. Department access boundary survived recovery. This completes the one-time file backup/restore milestone; scheduling, off-host copies, system-state and full-server recovery are outside this demonstrated result. No commits/publication yet.

E06 verifies exact dedicated test-file removal and Test-Path False, recovery from version10/07/2026-17:59 on E: with machineFS01/itemtypeFile/overwriteSkip, then successful original-location restore41 bytes/1 file/0 failures. Recovery log C:\Windows\Logs\WindowsServerBackup\FileRestore-07-10-2026_20-22-24.log. Restored content is FischerLab controlled file recovery test.; SHA256 equals saved original (comparison True); inherited SYSTEM/Admin Full and IT DL Modify ACL matches pre-restore evidence. No other files deleted/restored in this exercise. Next: authenticated employee read of the restored file as amelia and denied read as omora to corroborate access boundaries after restore. Backup remains same-host/local virtual disk, with no scheduled/off-host/full-server protection claimed.

E05 verifies backup version10/07/2026-17:59, target LabBackups(E:), and recovery capability Volumes/Files. wbadmin labels target1394/USB; underlying observed VMware disk remains the documented local virtual-disk target. Original file ACL inherited SYSTEM Full, BUILTIN Administrators Full and FISCHERLAB DL_FS01_IT_Modify Modify. Saved original SHA256 manifest readable and path matches dedicated test file. Next: remove only C:\Shares\IT\restore-validation.txt, verify absent, recover that exact file from version10/07/2026-17:59 to its original location using E:; verify restored hash equals saved manifest and ACL matches. No other share files are targets of deletion/recovery. Restore not yet performed.

E04 verifies Windows-Server-Backup install success/no restart; dedicated C:\Shares\IT\restore-validation.txt created41 bytes; original SHA256 displayed and exported to C:\LabScripts\restore-validation-hash.csv. wbadmin start backup -backupTarget:E: -include:C:\Shares -vssCopy prompted Selected Files on C: to E:, then reported backup successfully completed. Log path C:\Windows\Logs\WindowsServerBackup\Backup-07-10-2026_17-59-11.log. The completion label volume(C:) does not expand the requested scope to full C:; command specifies only C:\Shares. Next: inspect catalog version on E: and original test-file ACL before controlled file deletion/restore. Successful backup alone does not prove restore ability; no deletion/restore yet performed.

E03 verifies Disk1 online/basic19.98GB with LabBackups E: NTFS, Healthy(Basic Data Partition),19.93GB free. GPT selection was instructed but partition style is not independently shown in this capture. Disk0/C: remains present. Next: install Windows-Server-Backup, create a dedicated non-overwriting restore-validation.txt under IT, capture/export original SHA256 outside share path, then back up only C:\Shares to E: using VSS copy. This is a file/folder backup scope, not system-state or full-server protection. No test file, hash or completed backup yet captured.

E02 shows Disk0 online/basic59.88GB with200MB EFI and C:59.68GB NTFS, and new Disk1 Unknown20.00GB Not Initialized with all20GB unallocated. Disk1 is the verified blank target for GPT initialization and a full-size simple NTFS volume proposed as E: LabBackups. Existing Disk0/C: must not be selected for initialization/format. GUI execution remains pending.

E01 verifies FS-FileServer installed; reinstallation reports success/NoChangeNeeded/no restart. One VMware Virtual NVMe disk0, GPT,64,424,509,440 bytes (60GiB). C: NTFS volume64,078,475,264 bytes with41,724,518,400 free (about38.9GiB). D: has zero size/free and no filesystem shown; earlier CLIENT01 D: optical observation must not be used as FS01 proof. No separate backup data disk yet visible. Plan: gracefully shut down FS01, add a new20GiB virtual hard disk (not an existing disk), boot and inspect Disk Management before initializing anything. Proposed backup volume E: with label LabBackups; validate letter availability and disk identity first. This target shares VMware host storage and is suitable for a lab file-restore exercise, not independent disaster recovery. During FS01 shutdown, monitoring SMB reachability may intentionally fail and should recover after boot.

On FS01, use Get-Disk and Get-Volume to inspect current storage. No backup method, destination, role installation, disk initialization or restore operation has been performed.

## Git

Pending; no commits or publication yet.
