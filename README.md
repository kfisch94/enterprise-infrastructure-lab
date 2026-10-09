# Enterprise Infrastructure and IT Operations Lab

**Kyle Fischer · Personal lab**

Validated October 8, 2026 local / October 9 UTC.

A five-VM enterprise lab demonstrating Windows identity and file services, routed network controls, Linux monitoring, recovery and employee access lifecycle testing. The environment uses synthetic employees and runs on one VMware host; it represents personal lab work.

## Start here

- [Architecture and address plan](docs/architecture.md)
- [Validation results and limitations](docs/validation-summary.md)
- [Build history](docs/build-log.md)
- [Release review](docs/release-review.md)

![Fresh operations dashboard after reboot](evidence/016-post-reboot-validation/004-fresh-post-reboot-health-dashboard.png)

## Verified demonstrations

| Demonstration | Observed result | Evidence |
|---|---|---|
| Employee provisioning | 26 synthetic employees checked for identity, OU, department and group; no-change import rerun | [LAB-003](tickets/003-employee-provisioning.md) |
| Domain client and policy | Domain sign-in, secure channel, OU placement, sign-in notice and policy refresh | [LAB-004](tickets/004-client-domain-join.md), [LAB-006](tickets/006-workstation-group-policy.md) |
| Department permissions | IT and Accounting pilot users can access their own shares and are denied the other department's share; targeted drives | [LAB-007](tickets/007-department-file-services.md), [LAB-008](tickets/008-department-drive-mapping.md) |
| Operations monitoring | Unprivileged recurring collector, loopback dashboard over SSH, stale-data detection and recovery | [LAB-009](tickets/009-ubuntu-operations-server.md) |
| File recovery | One file deleted and restored; original SHA-256 and permissions preserved | [LAB-010](tickets/010-file-backup-and-restore.md) |
| Segmentation | Explicit service access and controlled denied OFFICE/SERVERS/OT paths with matching firewall logs | [LAB-011](tickets/011-firewall-hardening.md) |
| Firewall recovery and upgrade | Same-version configuration recovery evidence; staged upgrades from pfSense 2.6.0 to 2.9.0 with regression checks | [LAB-012](tickets/012-firewall-configuration-recovery.md) |
| Employee DNS filtering | Maintained HaGeZi threat feed, custom safe block test, permitted browsing and managed Edge DNS policy | [LAB-013](tickets/013-employee-network-access.md) |
| Intrusion detection | OFFICE passive Suricata sensor records benign SID 2100498; normal access preserved; log management configured | [LAB-014](tickets/014-suricata-intrusion-detection.md) |
| Employee offboarding | Disable/group removal, scoped SMB session closure, fresh sign-in and SMB rejection, unaffected employee access | [LAB-015](tickets/015-employee-offboarding.md) |
| Reboot recovery | Client services, authenticated SSH, fresh monitoring, new IDS alert and disabled-account state verified | [LAB-016](tickets/016-post-reboot-validation.md) |

## Environment

FW01 runs pfSense CE 2.9.0 with pfBlockerNG and Suricata. DC01 supplies Active Directory, DNS and Windows DHCP. FS01 provides department shares. OPS01 runs Ubuntu 26.04.1 and collects resource, DNS and TCP checks. CLIENT01 is the Windows 11 domain workstation.

SERVERS, OFFICE and OT use separate VMware subnets behind FW01. They are routed virtual networks, not VLANs. OT has no permanent industrial endpoint; segmentation tests used a temporary simulated endpoint. Same-subnet SERVERS traffic does not traverse FW01.

## Automation and runbooks

- [Directory structure setup](scripts/Initialize-LabDirectory.ps1)
- [Employee import](scripts/Import-LabEmployees.ps1) and [verification](scripts/Verify-LabEmployees.ps1)
- [Synthetic roster without passwords](data/simulated-employees.csv)
- [Monitoring runbook](docs/operations-monitoring.md)
- [File recovery runbook](docs/file-recovery.md)
- [Evidence guide](docs/evidence-guide.md) and [ticket template](tickets/TEMPLATE.md)

Scripts are lab examples. Review their parameters and prerequisites before running them; guest paths refer to the lab VMs.

## Scope and evidence

Results come from captured output and user-supplied observations. Tickets retain actual failures and distinguish later recovery from a proven root cause. Successful tests establish their recorded scope; they do not establish exhaustive security coverage.

Suricata is alert-only, with no TLS decryption. Monitoring checks DNS and TCP reachability; authenticated file access is tested separately. Backups remain on the same physical host, and restoration of the newest firewall export is untested. Scheduled rule updates and log rotation are configured but their scheduled execution has not been demonstrated. Remaining configuration evidence gaps are listed in the validation summary.

Encrypted firewall exports, passwords, keys and VM disks stay outside this public portfolio. Local text checks, screenshot OCR and visual overview are documented in the [release audit](docs/release-audit.md).
