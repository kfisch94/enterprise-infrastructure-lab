# LAB-004 — Join CLIENT01 and validate employee sign-in

**Owner:** Kyle Fischer\
**Opened:** October 6, 2026\
**Status:** Domain enrollment, pilot session, secure channel, and workstation placement validated; password-change confirmation tracked in LAB-003

## Request

Demonstrate office workstation domain enrollment and an employee's first sign-in with a password change.

## Plan

1. CLIENT01 remains attached to VMnet3, Office network.
2. Set temporary static address 10.10.20.50/24, gateway 10.10.20.1, preferred DNS 10.10.10.10, alternate blank.
3. Review existing OFFICE firewall rules before adding a labeled bootstrap rule: IPv4 pass, any protocol, source 10.10.20.50/32, destination 10.10.10.10/32. No OT access or general internet permission is implied. Place it above any matching explicit block; preserve existing rules as evidence.
4. Validate client DNS resolution and TCP 445 to DC01, then domain join.
5. Confirm guest hostname CLIENT01, join corp.fischerlab.test, and restart as required.
6. Sign in as FISCHERLAB/amelia, change temporary password, and capture whoami and group membership.
7. Move workstation computer object into FischerLab/Workstations after successful enrollment.
8. Replace bootstrap any-protocol access with documented AD-required services and test allow/deny behavior in a later firewall ticket. Do not present this bootstrap rule as the final hardened policy.

## Validation

Pending office rules review, applied static configuration, connectivity results, domain membership, first sign-in, password change, and workstation placement. Domain Administrator credentials are only for enrollment; daily employee sign-in uses the pilot user.

## Troubleshooting and Git commit

Supplied E01–E03 verify the applied bootstrap rule, hostname CLIENT01, entered static IP settings, and failed DNS/TCP tests while Ethernet0 reports Network cable unplugged. See [link-down incident](../docs/troubleshooting/002-client-network-disconnected.md). Restore the link and retest before pursuing DNS diagnosis.

Scope update from Kyle's DHCP question: configure Windows DHCP and pfSense relay before domain enrollment. Existing static IP is retained only for link recovery testing. Later replace it with automatic IPv4 and DNS and update the bootstrap rule for the DHCP source. Domain join and sign-in have not occurred.

Recovery E04 verifies client DNS and TCP 445 to DC01 from static 10.10.20.50. Connectivity incident resolved for tested paths. DHCP lease acquisition and renewed-source firewall access are next dependencies.

DHCP migration rule plan: change the temporary OFFICE-to-DC01 rule source from 10.10.20.50 to OFFICE net (10.10.20.0/24), retaining destination 10.10.10.10 and any IPv4 protocol for bootstrap only. This extends DC01 access to the office subnet; it does not authorize OT access. Final AD service restrictions remain required before representing the policy as hardened.

LAB-005 E06 confirms CLIENT01 now uses DHCP 10.10.20.100 with DC01 DNS. Next instructed steps: DNS/TCP retest from leased address, domain join via System Properties using enrollment credentials, restart, pilot employee first sign-in/password change, and workstation OU placement. No join or sign-in success is recorded yet.

Subsequent E05 shows fischerlab\amelia and FISCHERLAB\GG_IT_Users in the session token. Employee domain session verified in the guided CLIENT01 workflow; hostname, computer membership, secure channel, and workstation placement require corroboration. No screenshot of the password-change process or explicit confirmation of its completion has been supplied. Next steps: Get-CimInstance Win32_ComputerSystem identity query; elevated Test-ComputerSecureChannel; move CLIENT01 computer account from default Computers container to FischerLab/Workstations on DC01. Do not move DC01 out of Domain Controllers.

Final evidence E06/E07 confirms CLIENT01 domain membership (PartOfDomain=True), secure-channel=True, and workstation OU placement. These checks, together with E05 domain session, validate enrollment and employee use. First-sign-in password-change confirmation remains a separate LAB-003 item. Enrollment welcome dialog was not supplied, but final state is corroborated by actual membership and trust tests. Git commit pending.

Pending.
