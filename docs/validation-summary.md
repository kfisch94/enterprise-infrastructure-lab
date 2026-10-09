# Validation summary

Release-candidate state as of October 8, 2026 local / October 9 UTC. This summary describes observed results; detailed implementation history remains in tickets.

## Selected evidence

| Scenario | Result | Direct evidence |
|---|---|---|
| Live operations after reboot | Six DNS/TCP checks pass; snapshot six seconds old | [Dashboard](../evidence/016-post-reboot-validation/004-fresh-post-reboot-health-dashboard.png) |
| IDS persists after reboot | New benign UDP test triggers SID2100498 on OFFICE | [Alert](../evidence/016-post-reboot-validation/008-post-reboot-signature-alert.png) |
| Disabled employee cannot authenticate | Fresh interactive sign-in explicitly rejected; fresh SMB error1331 | [Sign-in](../evidence/015-employee-offboarding/006-disabled-account-sign-in-rejected.png), [SMB and unaffected employee](../evidence/015-employee-offboarding/007-amelia-read-disabled-smb-auth-rejected.png) |
| Reboot client smoke checks | Employee sign-in, OFFICE address, DNS block, IPv4 HTTPS200, file read and both policy updates pass | [Client output](../evidence/016-post-reboot-validation/001-client-post-reboot-checks-ssh-failed.png) |
| SSH recovery | Later authenticated CLIENT01 login and active SSH/monitoring services | [OPS01 output](../evidence/016-post-reboot-validation/003-ops01-services-ssh-login-recovered.png) |
| Current firewall resources | Interfaces up, DNSBL counts retained, memory21%, no swap | [FW01 output](../evidence/016-post-reboot-validation/005-fw-post-reboot-resources-dnsbl.png) |

The initial SSH probe in the client smoke check failed. A later accepted login establishes recovery, without proving why the first probe failed. A pre-reboot SMB probe also failed before a successful retry; its cause remains unconfirmed. These failures are retained in LAB-014/016.

## Demonstrated scope

- Onboarding: 26 synthetic roster users verified; import preview/apply/no-change rerun captured.
- Department access: IT and Accounting positive/negative share tests and targeted drive mappings.
- Recovery: one file restored with original SHA-256/ACL and department access; earlier same-version firewall configuration recovery plus staged upgrades/regression checks.
- Network controls: controlled routed allow/deny tests with target baselines and matching gateway logs, followed by cleanup.
- DNS filtering: downloaded threat list, safe custom block/allow checks, Edge DNS policy and tested direct external DNS failure.
- IDS: passive OFFICE capture and deterministic benign signature detection, including after reboot. The test packet is not evidence of an attack or compromise.
- Offboarding: enabled-user baseline, account disable/group removal, scoped active SMB-session closure, fresh online sign-in and SMB rejection, normal employee access and exact test-file cleanup.
- Persistence: post-reboot client services, running IDS/new alert, authenticated SSH, fresh monitoring and retained disabled-account state.

## Remaining evidence gaps and exclusions

| Area | What is not established |
|---|---|
| Network foundation | Independent original hypervisor mask captures for VMnet8/3/4 and exhaustive guest-MAC matching; guest interface settings and functional paths are separately documented |
| AD/DHCP | Exhaustive DC health auditing, reverse-DNS cleanup, dedicated initial relay-settings/Windows lease-table evidence; CLIENT01 lease/reservation and domain functions are demonstrated |
| Workstation policy | Credential-on-wake test and every GPO setting; sign-in notice, reported idle lock and policy application are documented |
| Drive lifecycle | Automatic removal of obsolete department mappings after a group change; offboarding tests authentication/session closure instead |
| Recovery | Off-host backup, bare-metal recovery, snapshot revert and restore of the newest encrypted firewall checkpoint |
| DNS controls | Prevention of all encrypted DNS, application/VPN bypasses, URL-path filtering or category enforcement |
| IDS | IPS prevention, TLS decryption, all-category saved enumeration, final reduced EVE output/statistics corroboration, scheduled update/rotation execution or quantified throughput |
| Monitoring | Authenticated LDAP/SMB checks from the collector, historical metrics, alerts/notifications or production availability guarantees |
| Offboarding | Cloud-session revocation, cached offline logon prevention, global token invalidation or recovery of previously copied files |
| Resilience | HA, independent physical storage, production OT or industrial-device testing |

Some early tickets retain incomplete documentation status. Later tickets establish specific operational results rather than silently changing the original record. No Git commit or publication is claimed before it occurs.
