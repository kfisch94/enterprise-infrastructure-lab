# Build and validation log

Dates use America/Denver. Record actual results separately from planned work. Entries preserve the state at the time of capture, including plans later completed. For current acceptance and remaining limitations, see [validation summary](validation-summary.md).

| Date | Activity | Evidence / source | Status |
|---|---|---|---|
| 2026-10-08 local / Oct9 UTC | Post-reboot acceptance complete | [LAB-016](../tickets/016-post-reboot-validation.md) | Employee services/GPO, authenticated SSH, fresh six-check dashboard, new IDS alert and retained disabled identity verified; earlier SSH failure cause unproven |
| 2026-10-08 | Employee offboarding complete | [LAB-015](../tickets/015-employee-offboarding.md) | Temporary-user positive baseline, disable/group removal/session closure, fresh sign-in/SMB rejection, employee continuity and cleanup |
| 2026-10-08 | Initial OFFICE IDS milestone complete | [LAB-014](../tickets/014-suricata-intrusion-detection.md) | Running alert-only sensor, benign SID2100498, access checks, configured log cap and encrypted private checkpoint |
| 2026-10-08 | Employee web/DNS filtering complete | [LAB-013](../tickets/013-employee-network-access.md) | Scoped web egress, downloaded threat feed, safe blocked/allowed tests and managed Edge DNS policy |
| 2026-10-08 | Firewall recovery/upgrade milestone complete | [LAB-012](../tickets/012-firewall-configuration-recovery.md) | Staged upgrades to CE2.9.0 and scoped regression/segmentation checks; newest-export restore untested |
| 2026-10-07 | FW01 encrypted backup and post-restore checks | LAB-012 E01–E09 | Private host export36,692bytes/hash recorded; All/packages/SSH keys/encryption options captured; rollback snapshot present; requested restore followed by reboot/intact rules/relay and successful client/server smoke tests. Explicit password-acceptance submission not pictured; current updater offers2.7.0 while official release table lists2.9.0; upgrade-path review pending |
| 2026-10-07 | Completed scoped firewall-hardening validation | LAB-011 E01–E50 | Required client functions, server web and fresh IPv4 NTP response pass; controlled blocked paths have gateway logs and target baselines; temporary resources removed and CLIENT01 restored with successful employee policy/drive checks. Original policy stall cause unproven; no exhaustive protocol or production OT claim |
| 2026-10-07 | Narrowed SERVERS access and validated simulated OT segmentation | LAB-011 E16–E49 | Both SERVERS defaults disabled; DNS/web and restored employee access pass; named gateway blocks deny controlled OFFICE/OT paths; temporary endpoint/resources removed and CLIENT01 OFFICE DHCP restored. Original user-policy timeout clears after fresh session; root cause unproven. Outbound server NTP probe pending |
| 2026-10-07 | Replaced OFFICE bootstrap rule and tested filtering | LAB-011 E01–E15 | Explicit AD/DHCP/ICMP policy with TEMP disabled; allowed client functions pass; confirmed listener8443 reachable from OPS01 but OFFICE default-deny logs CLIENT01 SYNs; temporary listener/host exception removed. SERVERS/OT work pending |
| 2026-10-07 | FS01 local file backup and controlled recovery completed | LAB-010 E01–E08 | Dedicated41-byte file restored from E: backup; SHA256/ACL match; IT allowed and Accounting denied after restore. Same-host storage only; no off-host/full-server recovery claim |
| 2026-10-07 | Completed26-employee onboarding | LAB-003 E04–E08 | Preview24 new/2 existing; apply24 creations/2 Department updates; all26 identity/OU/group checks pass, zero extras, new-account password flags verified; rerun makes no changes |
| 2026-10-07 | OPS01 Linux networking, restricted SSH, UFW, recurring health collector and dashboard completed | LAB-009 E01–E23; scripts and monitoring runbook | Verified static configuration, synchronized clock, authenticated SSH, DHCP reservation/rule, controlled stale-data/recovery and automatic monitoring/firewall startup after reboot; DNS/TCP checks only |
| 2026-10-06 | Host inventory recorded | Kyle's supplied specifications | User-reported |
| 2026-10-06 | Five lab VM names identified | Supplied VMware library screenshot | Observed names; guest readiness unknown |
| 2026-10-06 | Existing VMnet8 NAT identified | Supplied Virtual Network Editor screenshot | Observed initial configuration |
| 2026-10-06 | Internal networks and VM connections configured | Kyle: “Network interfaces are configured” | User-reported; evidence pending |
| 2026-10-06 | Internal network rows reviewed | E01 saved under evidence/001-network-foundation | VMnet2/3/4 subnets, no host connection, and no VMware DHCP visible; VMnet2 /24 mask verified |
| 2026-10-06 | FW01 internal adapter MACs reviewed | E02 adapter 2/3/4 captures saved | Verified against VMware settings; pfSense matching pending |
| 2026-10-06 | FW01 WAN adapter MAC recorded | E02 adapter 1 capture saved; Kyle reports VMnet8 | 00:0C:29:32:CC:DF verified in screenshot; adapter shown as NAT |
| 2026-10-06 | FW01 resource discrepancy identified | E02 settings show 256 MB RAM and 1 processor | Requested 2 GB RAM and 2 vCPU before boot; change pending |
| 2026-10-06 | Portfolio documentation starter created | Files in this folder | Complete |
| Pending | Verify adapter MAC mapping and assign FW01 interfaces | E01–E03 | Pending |
| 2026-10-06 | FW01 interface addresses displayed | E04 console screenshot saved | Planned internal gateways and WAN DHCP lease observed; MAC matches and connectivity pending |
| 2026-10-06 | pfSense version captured | E04 | 2.6.0-RELEASE amd64; version review pending |
| 2026-10-06 | DC01 bootstrap IPv4 settings reviewed | E06 IPv4 properties screenshot saved | Entered values match plan: 10.10.10.10/24, gateway and temporary DNS 10.10.10.1; application and connectivity pending |
| 2026-10-06 | pfSense web management accessed from DC01 | E07 dashboard shows admin@10.10.10.10 | Management access and authentication verified |
| 2026-10-06 | FW01 resources corrected | E07 shows 2 CPUs, 1 package x 2 cores, 1982 MiB RAM | Requested CPU/RAM correction verified |
| 2026-10-06 | Interface labels and link status observed | E07 | WAN, SERVERS, OFFICE, OT show up; internet, DNS and isolation tests pending |
| 2026-10-06 | DC01 gateway, upstream IPv4, and DNS tests completed | E05 actual PowerShell output | Pass: both pings 4/4; example.com resolved through 10.10.10.1 |
| 2026-10-06 | WAN top-level settings reviewed | E08 | DHCP IPv4 verified; filtering checkboxes not visible |
| 2026-10-06 | SERVERS DHCP configuration reviewed | E09 | Enable unchecked; OFFICE/OT status and saved WAN filtering still pending |
| 2026-10-06 | WAN reserved-network filtering reviewed | E10 supplied as WAN capture | Private-network blocking unchecked; bogon blocking checked |
| 2026-10-06 | Internal interface settings reviewed | E11–E13 | All enabled; planned .1/24 addresses; IPv6 None; upstream gateway None; private/bogon blocking unchecked |
| 2026-10-06 | DC01 identity and OS preflight | LAB-002 E01 | Pass: DC01, WORKGROUP, PartOfDomain=False, Windows Server 2022 Standard |
| 2026-10-06 | AD DS role and management tools installed | LAB-002 E02 | Success=True, Restart Needed=No; role state Installed |
| 2026-10-06 | Lab forest namespace selected | LAB-002 plan | corp.fischerlab.test / FISCHERLAB; promotion pending |
| 2026-10-06 | Post-restart domain identity recorded | LAB-002 E03 | DC01.corp.fischerlab.test displayed; AD/DNS health validation pending |
| 2026-10-06 | Simulated employee CSV inspected | User-provided Users.csv | 26 rows; columns FirstName, LastName, Department, Username, Password; no duplicate usernames or missing required identity fields; workbook equivalence not checked |
| 2026-10-06 | AD domain, services, and DNS validated | LAB-002 E04–E06 | FISCHERLAB / Windows2016Domain; NTDS/DNS/Netlogon running; host/SRV/external queries passed; dcdiag basic DNS passed |
| 2026-10-06 | Reverse-DNS observation recorded | LAB-002 E05 | nslookup Server: Unknown; likely missing PTR, follow-up pending |
| 2026-10-06 | Public synthetic roster and directory setup script prepared | data/simulated-employees.csv and scripts/Initialize-LabDirectory.ps1 | Password column excluded; script lab execution pending |
| 2026-10-06 | Directory automation execution-context error diagnosed | Kyle's pasted PowerShell output; troubleshooting/001-directory-script-console-context.md | Script sections pasted interactively; PSCmdlet null; create loops stopped before mutations; corrected run pending |
| 2026-10-06 | Saved directory script preview validated | LAB-002 E07 screenshot | Test-Path=True; ten OU and five group operations previewed; no errors or directory changes; execution-context issue resolved |
| 2026-10-06 | Directory structure applied and rerun validated | LAB-002 E08/E09 | Ten OUs and five groups CREATED; second run EXISTS for all; OU tree confirmed in ADUC |
| 2026-10-06 | Pilot employee configured manually | LAB-003 E01–E03 | Aled Melia / amelia in IT; Domain Users and GG_IT_Users; next-sign-in password change required; workstation sign-in pending |
| 2026-10-06 | CLIENT01 connectivity failure captured | LAB-004 E01–E03 | OFFICE rule applied; hostname CLIENT01; guest Ethernet reports cable unplugged; DNS/TCP fail; adapter check pending |
| 2026-10-06 | CLIENT01 connectivity recovery validated | LAB-004 E04 | DNS lookup successful; TCP 445 True from Ethernet0 / 10.10.20.50; exact virtual-adapter change not captured |
| 2026-10-06 | DHCP role installation and scope captured | LAB-005 E01–E03 | Install success/no restart; OFFICE pool 10.10.20.100–199; option names present, values/state/authorization pending |
| 2026-10-06 | OFFICE scope option values verified | LAB-005 E04 improved screenshot | Options 003/006/015 match plan; service/authorization/scope state pending |
| 2026-10-06 | Windows DHCP readiness verified | LAB-005 E05 | Service Running; DC01 authorized; OFFICE scope Active /24 with correct range; relay/client lease pending |
| 2026-10-06 | CLIENT01 DHCP lease validated | LAB-005 E06 | 10.10.20.100/24, DC01 DHCP/DNS, gateway 10.10.20.1, suffix corp.fischerlab.test, DHCP enabled; relay/rule/server lease screenshots pending |
| 2026-10-06 | Pilot domain session validated | LAB-004 E05 | whoami=fischerlab\amelia; GG_IT_Users in token; host/secure-channel corroboration and OU placement next |
| 2026-10-06 | CLIENT01 enrollment and OU placement validated | LAB-004 E06/E07 | CLIENT01 domain member=True, secure-channel=True, Workstations OU confirmed |
| 2026-10-06 | Workstation GPO configured and applied | LAB-006 E01/E02 | Three values match plan; gpupdate succeeded; gpresult lists FL-Workstations-Baseline on CLIENT01 from DC01; behavioral tests pending |
| 2026-10-06 | CLIENT01 sign-in notice verified | LAB-006 E03 | Notice title/text displayed; ten-minute lock reported by Kyle, password-on-wake confirmation pending |
| 2026-10-06 | FS01 enrolled and placed in Servers OU | LAB-007 E01–E04 | Windows Server 2022 Standard; domain member=True; Servers OU confirmed; IP/role/group/share validation pending |
| 2026-10-07 | File-access group design and FS01 network checked | LAB-007 E05–E09 | Domain-local security groups and nesting displayed; FS01 IP/gateway/DNS match; File Server role Available; installation/shares pending |
| 2026-10-07 | Department NTFS and share permissions reviewed | LAB-007 E10–E15 | Department Modify and Change/Read displayed; share administrative principal is individual Administrator, correction to local Administrators requested; client tests pending |
| 2026-10-07 | Share administrative group lookup issue reported | Kyle: Administrators not found | Existing local group visible in NTFS; object-picker location/type review requested; resolution pending |
| 2026-10-07 | Share administrative principal correction verified | LAB-007 E17/E18 | Local FS01 Administrators Full Control on both shares; individual Administrator absent; lookup issue resolved |
| 2026-10-07 | OFFICE SMB and IT browsing verified | LAB-007 E19–E22 | Applied TCP445 rule; amelia connects from DHCP address; IT test file visible; Accounting error still checking, precise denial pending |
| 2026-10-07 | Accounting authorization denial verified | LAB-007 E23 | Final no-permission error confirms expected department restriction; explicit IT read/edit output still pending |
| 2026-10-07 | IT file creation and readback validated | LAB-007 E24 | amelia; initial exact path missing; Add-Content created it and readback succeeded; existing-file modification retest pending |
| 2026-10-07 | IT existing-file modification validated | LAB-007 E25 | Second append/readback succeeds; IT create/read/modify and Accounting denial pilot checks complete |
| 2026-10-07 | IT drive targeting and mapping verified | LAB-008 E01–E03 | IT user group condition, I: configuration, connected mapping and file readback verified; gpresult/Accounting test pending |
| 2026-10-07 | Accounting mapping and isolation validated | LAB-008 E04–E11 | omora session, Accounting OU, user GPO, nested groups, Q mapping, Accounting write/read, IT denied; Q reconnect unchecked, correction requested |
| 2026-10-07 | Accounting reconnect configuration corrected | LAB-008 E12 | Reconnect checked; current mapping configuration matches plan |
| 2026-10-07 | OPS01 Linux preflight captured | LAB-009 E01/E02 | Ubuntu 26.04.1 LTS, ops01, ens33 UP without IPv4/routes, 00-installer-config.yaml present; existing config inspection next |

## Working rules

October 8, 2026 local / October9 UTC — LAB-016 scoped all-VM post-reboot validation complete. Normal employee DNS block/HTTPS/file access/GPO refresh pass; initial OPS01 SSH probe fails but later authenticated login and active SSH/timer/dashboard prove recovery. Fresh monitoring snapshot all6checks pass. FW interfaces/DNSBL/resources retained; OFFICE Suricata running and new SID2100498 alert captured; offboard.test remains disabled with no explicit memberships. Initial SSH cause unknown; no HA/load/restore or scheduled maintenance execution claims. Portfolio release preparation next.

October 8, 2026 — LAB-015 scoped employee offboarding complete. Temporary IT identity proved file write/read; exact account disabled/IT group removed; matching FS01 SMB session closed. DC01 reachable, fresh interactive sign-in rejected and separate netonly SMB authentication fails1331/account disabled. Amelia reads preserved file; exact exercise file removed and existing restore-validation file remains readable. Test account retained disabled. Cloud sessions, cached offline sign-in and global token revocation outside scope.

October 8, 2026 — LAB-014 initial OFFICE alert-only IDS milestone complete. FW01 memory4GiB, Suricata GUI7.0.9_1/engine8.0.5_1 installed, ET Open manual update successful, OFFICE running with blocking disabled, SID2100498 benign UDP test alert captured, DNS/HTTPS/SMB and user-confirmed IT share checks pass. Log management enabled with512MB combined cap; new encrypted private checkpoint85,617bytes/checksum recorded. Initial SMB timeout and test-host DNS failure retained without unsupported cause claims. IPS prevention, TLS decryption, reboot persistence, scheduled updates/rotation execution, final EVE stats and checkpoint restore not claimed.

October 8, 2026 — LAB-012 scoped milestone complete: encrypted private host checkpoints retained; sequential FW01 upgrades reach 2.9.0; expected interfaces/rules, service checks and logged controlled OFFICE/OT denies verified. Temporary test cleanup and CLIENT01 OFFICE restoration confirmed. Final backup checksum/encrypted format independently recorded (E42/E43). Final backup restore, snapshot revert, exhaustive coverage and off-site recovery are not claimed. Repository publication remains pending.

- Never record a successful test based on expected behavior alone.
- Document real errors without rewriting history. Label deliberately introduced faults as exercises.
- Save useful milestones, not every click.
- Record the command or UI test, expected result, actual result, and evidence path.
- Add Git commit references after commits exist. No commits or GitHub publication have been performed yet.
