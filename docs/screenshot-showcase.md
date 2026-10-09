# Top 10 screenshot showcase

Use these in order for a walkthrough: overall operations, architecture, identity, employee access, recovery, controls, and offboarding. Keep the original screenshot captions and supporting evidence; avoid presenting one screen as proof of every service.

## 1. Operations dashboard after reboot

[004-fresh-post-reboot-health-dashboard.png](../evidence/016-post-reboot-validation/004-fresh-post-reboot-health-dashboard.png)

Fresh metrics and six passing DNS/TCP endpoint checks after restart.

## 2. Firewall and network overview

[005-fw-post-reboot-resources-dnsbl.png](../evidence/016-post-reboot-validation/005-fw-post-reboot-resources-dnsbl.png)

Four active interfaces, retained DNS filtering, and modest resource use.

## 3. Active Directory organization

[009-directory-ou-tree.png](../evidence/002-active-directory/009-directory-ou-tree.png)

Department OUs, groups, servers, users, and workstations organized in the domain.

## 4. Employee provisioning verification

[008-final-employee-verification.png](../evidence/003-employee-provisioning/008-final-employee-verification.png)

26 simulated employees checked for identity, OU placement, department, and group membership.

## 5. Employee policy and mapped-drive access

[049-restored-office-employee-policy-drive-pass.png](../evidence/011-firewall-hardening/049-restored-office-employee-policy-drive-pass.png)

Successful policy refresh, department drive policy, and file read after network testing.

## 6. Department permission boundaries

[011-accounting-write-read-it-denied.png](../evidence/008-department-drive-mapping/011-accounting-write-read-it-denied.png)

Accounting pilot writes and reads its own share while IT access is denied.

## 7. File recovery with integrity verification

[006-controlled-deletion-restore-hash-acl.png](../evidence/010-file-backup-and-restore/006-controlled-deletion-restore-hash-acl.png)

Deleted test file restored with matching SHA-256 and preserved permissions.

## 8. Controlled network segmentation test

[045-verified-ot-listener-repeat-block-log.png](../evidence/011-firewall-hardening/045-verified-ot-listener-repeat-block-log.png)

Firewall records denied traffic to a temporary OT endpoint after its listener was verified.

## 9. Intrusion detection after reboot

[008-post-reboot-signature-alert.png](../evidence/016-post-reboot-validation/008-post-reboot-signature-alert.png)

A new benign test packet triggers Suricata SID 2100498 after restart.

## 10. Offboarding without disrupting another employee

[007-amelia-read-disabled-smb-auth-rejected.png](../evidence/015-employee-offboarding/007-amelia-read-disabled-smb-auth-rejected.png)

Amelia can read the test file; the disabled test account receives SMB error 1331.

The segmentation result is paired with a known-listening-target baseline and repeat test in [LAB-011](../tickets/011-firewall-hardening.md). Domain secure-channel output and DNS filtering tests remain in their corresponding milestone evidence.
