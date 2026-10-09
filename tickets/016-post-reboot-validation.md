# LAB-016 — Post-reboot service validation

**Owner:** Kyle Fischer
**Opened:** October 8, 2026 (local; initial check HTTP response October9 UTC)
**Status:** Complete — scoped post-reboot service recovery and persistence verified

## Request and scope

User reports rebooting all VMs after LAB-014/015. Verify service recovery before release; retain failures and investigate without broad policy changes. User-reported reboot is context, not independently recorded boot times or boot order.

## Validation

E08 post-reboot OFFICE alert atOct9 02:11:01UTC, UDPCLIENT10.10.20.100:62252 ->DC01 10.10.10.10:123, GID:SID1:2100498/priority2, expected GPL ATTACK_RESPONSE id check returned root. Confirms running sensor still captures/matches loaded signature after reboot. E09 DC01 offboard.test EnabledFalse/MemberOf{} establishes retained disabled state and no explicit access-group membership (primary Domain Users remains implicit). Scoped validation complete: client sign-in/Office address, DNS block/HTTPS, authenticated file read, user/computer GPO refresh, recovered authenticated SSH, active monitoring services/fresh six-check dashboard, running passive IDS/new signature alert, FW interfaces/DNSBL/resources and disabled identity state. Earlier failed SSH probe remains documented; later accepted login verifies recovery without proven initial cause. Not a resilience/load/HA test, exhaustive domain audit, fresh post-reboot offboard sign-in/SMB denial retest, new backup restore or scheduled rotation/update test.

E06 benign UDP test payload sent DC01:123 with23byte Send result; no new alert supplied. E07 main FW dashboard at02:13:12UTC uptime23m38s, CPU2%memory21%/swap0%, interfaces/DNSBL counts retained. Resource second observation passes; no signature detection or disabled-account persistence inferred from this dashboard. Await actual Suricata Alerts row/new timestamp and DC01 Get-ADUser result.

E04 CLIENT browser127.0.0.1:8080 dashboard Checks passing, OPS01 uptime8min, snapshot age6s/collected2026-10-09T02:07:11.641Z; all six DNS/TCP checks PASS, memory10.9%/4.7GiBavailable, root30.5%/6.3GiBfree, load0.00. SSH tunnel workflow context and prior loopback listener support secure tunneled access; tunnel command not separately captured. Snapshot freshness and collector recovery verified, not authenticated LDAP/SMB health (CLIENT file test separately does file read). E05 FW01CE2.9.0 uptime18m39s at02:08:13UTC Oct9, twoCPUs, memory21%of4035MiB/swap0%, CPU2%, root8%of16G; four expected interface addresses up and DNSBLcustom2/threat239206 retained. Single resource observation not a load test. Next fresh benign IDS alert and DC01 disabled-test-account query; no policy changes needed.

E03 OPS01 ens33 UP10.10.10.30/24, default10.10.10.1; ssh.service and socket active/enabled, service started01:59:13UTC Oct9, accepted password for kf fromCLIENT10.10.20.100:65253 at02:00:06UTC. This verifies authenticated SSH access after earlier failed probe; first failure cause not proven (service startup shown later than initial01:53HTTPS response). ss shows SSH0.0.0.0/[::]:22 and Python dashboard only127.0.0.1:8080; health timer and dashboard is-active both active. Script result health freshness/content not shown. No broad configuration change reported. Next recreate CLIENT SSH tunnel and inspect fresh dashboard/status, then resource and disabled-account persistence checks.

E01 CLIENT whoami fischerlab\amelia, IPv4 10.10.20.100/24 gateway10.10.20.1/domain suffix corp.fischerlab.test. Standard ipconfig does not show DNS server. example.org A0.0.0.0, IPv4 HTTPSexample.com HTTP200 response Fri09Oct2026 01:53:42GMT, FS01 restored validation file read succeeds. DC-mediated computer and user gpupdate both completed successfully. OPS01 10.10.10.30 TCP22False fromCLIENT10.10.20.100/ping timeout; cause unproven, no SSH or monitoring recovery claim. E02 OFFICE/em2 Suricata green running status with blocking DISABLED after reported reboot; no manual startup reported, but startup journal not supplied. This corroborates running post-reboot state, not fresh signature test.

## Next checks

All scoped acceptance checks above completed. Next portfolio release preparation: consolidate current architecture/status, retain failure evidence, audit public artifacts for private data and validate documentation links. Production resilience, exhaustive domain auditing and backup restoration remain separate work.
