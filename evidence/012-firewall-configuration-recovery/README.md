# LAB-012 evidence — FW01 configuration recovery and version review

- `001-host-backup-properties.png`: Host C:\\LabBackups\\FW01 backup file36,692bytes; preserved outside portfolio.
- `002-backup-metadata.txt`: Read-only inspection records filename,size,SHA256 and encrypted-format marker only. No secret payload.
- `003-encrypted-all-backup-options.png`: All/packages/SSH keys included, RRD/extra omitted, encryption selected and passwords masked.
- `004-updater-offers-270-from-260.png`: Installed2.6.0, local Latest stable(v2.7.0) branch offers2.7.0; no upgrade. Official release review recorded separately.
- `005-fw01-rollback-snapshot-present.png`: FW01 snapshot node exists; label truncated and You Are Here selected, full details not visible. Recovery/revert untested.
- `006-post-restore-dashboard.png`: After requested restore,2.6.0 uptime3m37s and expected four interface addresses;2cores/~2GiB/ZFS16G visible. Restore submission not shown.
- `007-post-restore-servers-rules.png`: Explicit SERVERS rule order, blocks and disabled default allows intact; DNS/web/NTP traffic counters visible.
- `008-post-restore-office-relay.png`: OFFICE relay enabled to DC0110.10.10.10; baseline intact. Functional smoke tests pending.
- `009-post-restore-client-services-ops-https-pass.png`: After requested restore, CLIENT01 renewal/external DNS/user policy/mapped IT file pass and OPS01 IPv4 HTTPS200. Upgrade-path review remains pending.
- `010-no-installed-addon-packages.png`: Package Manager shows no add-on packages installed.
- `011-updater-only-260-270-branches.png`: Expanded Branch list offers Latest2.7.0/Previous2.6.0 only. Repository/upgrader refresh investigation next; no upgrade performed.
- `012-upgrade-to-270-dashboard.png`: After user Confirm,2.7.0 boots with1m45s uptime and expected four interface addresses. Intermediate upgrade; regression tests/new branch review pending.
- `013-270-client-services-ops-https-pass.png`: Post2.7.0 DHCP/DNS/user policy/mapped IT read and OPS01 IPv4 HTTPS200 pass.
- `014-270-servers-rules-preserved.png`: Restricted SERVERS order/blocks and disabled defaults intact; relay reply counter342B visible.
- `015-270-updater-exposes-281-branch.png`: Branch list now contains Previous Stable2.8.1 and2.7.0;2.7.0 selected. Inspect2.8.1 offer and preserve fresh backup before next upgrade.
- `016-281-update-check-failure.png`:2.8.1 selected; Unable to check for updates, no available-version result. Cause pending console diagnostics.
- `017-270-encrypted-host-backup-properties.png`: Separate post2.7.0 host backup36,887bytes; encrypted format/hash independently verified.
- `018-270-backup-metadata.txt`: Nonsecret size/hash/encrypted-format metadata for new backup; restore not tested.
- `019-281-offer-check-recovered.png`: Check now offers2.8.1 from2.7.0; Confirm available. Prior check failure cause unproven; upgrade next, not yet captured.
- `020-281-dashboard-290-available.png`:2.8.1 boots uptime1m05s with expected interfaces;2.9.0 advertised. Final-stage review/functional checks pending.
- `021-281-servers-rules-preserved.png`: Restricted rules/blocks and disabled defaults preserved on2.8.1; counters alone not functional validation.
- `022-290-final-stage-offer.png`: Current Stable2.9.0 selected, current2.8.1/latest2.9.0. Smoke checks/fresh backup pending before Confirm.

- `023-281-functional-checks.png`: CLIENT01 DHCP, DNS, user policy and mapped file pass; OPS01 IPv4 HTTPS returns 200 after 2.8.1.
- `024-281-host-backup-properties.png`: Separate 37,582-byte checkpoint saved beside earlier exports. Host read confirms salted encrypted format and SHA256 recorded in ticket; checkpoint restore not tested.

- `025-290-dashboard.png`: 2.9.0-RELEASE boot, uptime 1m25s, expected four interfaces up; dashboard reports latest version.
- `026-290-servers-rules.png`: Scoped permissions, logged OFFICE/OT blocks and disabled broad defaults remain visible.
- `027-290-office-rules.png`: DC service permissions, restricted SSH/FS01 SMB and disabled temporary rule remain visible.

- `028-290-client-functional-checks.png`: DHCP renewal, external DNS, DC discovery, user policy, mapped file and restricted OPS01 SSH TCP reachability pass.
- `029-290-ops-https-health.png`: IPv4 HTTPS 200 and fresh healthy monitoring response with DNS/DC TCP53 checks.
- `030-290-health-checks-continuation.png`: DC LDAP, FS01 SMB and local SSH TCP checks pass; explicit monitoring scope visible.

- `031-290-office-deny-host-rule-denied.png`: Local listener test true and OPS01 timeout; host allow-rule creation failed with Access denied, requiring an elevated retry.
- `032-290-office-deny-firewall-log.png`: Five new 04:57:47–51 SYN entries match intended SERVERS-to-OFFICE block; older entries are historical.

- `033-290-office-deny-elevated-retry-cleanup.png`: Elevated allow-rule creation succeeds, OPS01 retry times out, listener stop and rule removal complete without errors. Refreshed second-attempt log and absence checks pending.

- `034-290-office-test-cleanup-verified.png`: Listener and temporary rule absence independently confirmed, both False.
- `035-290-office-retry-block-log.png`: Five new corrected retry SYN blocks at 05:01:18–22 from source port 38032 match intended block rule.

- `036-290-ot-listener-bind-failed.png`: Address setup issued; listener bind fails, local test false, same named temporary rule already exists. Later DC445 failure uses OT source. Prerequisites need correction.
- `037-290-ot-incomplete-attempt-ops.png`: DC445 positive control connects, OT8443 times out; target listener failure prevents counting controlled deny pass.

- `038-290-ot-test-prerequisites-ready.png`: OT IPv4 Preferred, scoped temporary rule created, listener starts and local TCP8443 succeeds. Target prerequisites corrected; remote retry pending.

- `039-290-servers-to-ot-block-log.png`: Newest five SYN entries at 17:00:38–42 match named SERVERS-to-OT block; older groups retained as history.
- `040-290-ot-to-dc-default-deny-log.png`: Newest five SYN entries at 17:00:48–17:01:03 match OT default deny for DC01 TCP445. No repeated terminal output supplied with these logs.

- `041-290-ot-cleanup-office-restoration.png`: Listener/rule absence both False; CLIENT01 DHCP address/gateway/DNS restored to OFFICE; user policy and mapped file pass.

- `042-290-final-backup-properties.png`: Final 37,582-byte host backup, filename and older checkpoints retained.
- `043-290-final-backup-metadata.txt`: Independently verified final SHA256 and encrypted-format indicators; no backup contents or password included.

Scoped milestone complete; see ticket for validation limits. Final checkpoint restore remains untested. Do not store configuration exports, decryption passwords or sensitive file contents here. Export possession is distinct from a validated restore.
