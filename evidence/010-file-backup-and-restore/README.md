# LAB-010 evidence — File backup and restore

- `007-accounting-denied-restored-file.png`: fischerlab\omora denied read of the restored IT test file.
- `008-it-read-restored-file.png`: fischerlab\amelia successfully reads the restored file's original content via UNC path. Positive/negative employee access boundary verified after restore.

- `006-controlled-deletion-restore-hash-acl.png`: Controlled deletion of exact test file (absence False), successful41-byte/1-file recovery with0 failures, original content, SHA256 comparison True and original inherited permissions restored. Employee positive/negative access validation pending.

- `005-backup-catalog-original-acl-hash.png`: E: catalog version10/07/2026-17:59 supports file recovery; original inherited SYSTEM/Admin Full and IT Modify permissions; saved SHA256 manifest readable. Controlled deletion/restore pending.

- `004-test-hash-and-successful-backup.png`: WSB installed without restart, dedicated41-byte test file created, SHA256 recorded/exported, selected C:\Shares backup to E: with VSS copy successfully completed. Catalog and restore checks pending.

- `003-labbackups-volume-ready.png`: Disk1 online/basic with healthy NTFS LabBackups E:19.98GB,19.93GB free. Existing C:/EFI retained; first backup pending.

- `002-new-backup-disk-uninitialized.png`: Verified new Disk1,20.00GB, Unknown/Not Initialized, entirely unallocated; Disk0 contains existing EFI and C: volumes. GPT/NTFS initialization not yet performed.

- `001-fs01-role-and-storage-preflight.png`: File Server role installed; disk0 GPT60GiB; C: NTFS with approximately38.9GiB free; no separate backup disk visible. D: has no filesystem/size shown. Backup and restore not yet performed.

Keep storage-selection screenshots before initialization, backup completion evidence and restored-file verification as separate checkpoints. Label controlled test deletions and distinguish local virtual-disk backup from host-independent protection.
