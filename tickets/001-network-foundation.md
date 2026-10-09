# LAB-001 — Build the routed network foundation

**Owner:** Kyle Fischer\
**Opened:** October 6, 2026\
**Status:** In progress; virtual wiring reported configured, guest mapping pending

## Request

Provide separate Servers, Office, and Field networks with pfSense as the gateway and VMware NAT as the upstream connection.

## Plan

1. Preserve VMnet8 NAT and its DHCP service.
2. Create VMnet2/3/4 as internal networks without VMware DHCP or host adapters.
3. Attach four FW01 adapters and one adapter per initial guest.
4. Identify pfSense interfaces by matching VMware MAC addresses.
5. Assign WAN/LAN/OPT interfaces and addresses from the architecture plan.
6. Validate gateway access, upstream access, and DNS in later checkpoints.

## Implementation

- Kyle reports network interfaces configured.
- Supplied screenshots verify internal network rows and adapter 2/3/4 MAC assignments. Evidence files have been saved and captioned.
- VMnet2 mask verified as /24. VMnet3/4 masks require selected-network review.
- Guest interface mapping and IP configuration: pending.
- Console evidence: pfSense 2.6.0-RELEASE; em0 WAN 192.168.170.128/24 via DHCP; em1 LAN 10.10.10.1/24; em2 OPT1 10.10.20.1/24; em3 OPT2 10.10.30.1/24. Guest MAC comparison remains pending.
- pfSense private-network WAN filtering will be adjusted for the private VMware upstream when we reach the web setup wizard.
- DC01 IPv4 dialog shows planned bootstrap values: 10.10.10.10/24, gateway 10.10.10.1, temporary DNS 10.10.10.1. Saving and connectivity are not yet verified (E06).
- Subsequent dashboard E07 confirms authenticated management access from 10.10.10.10, corrected FW01 CPU/RAM, and interface labels SERVERS, OFFICE, OT. WAN filtering and DHCP server settings remain unverified.

## Failure / troubleshooting

No runtime failure has been reported. Pre-boot review found FW01 configured with 256 MB RAM and 1 processor. Requested adjustment to 2048 MB RAM and 1 processor / 2 cores; correction is not yet confirmed. This is a configuration finding, not a demonstrated troubleshooting incident.

Resolution: E07 dashboard subsequently confirms 1982 MiB visible RAM and 2 CPUs (1 package x 2 cores). Resource finding resolved.

## Validation

| Test | Expected result | Actual result | Evidence |
|---|---|---|---|
| Virtual network review | Correct subnets; internal VMware DHCP off | Internal rows verified; VMnet2 mask verified, VMnet3/4 masks pending | E01 |
| MAC mapping | Each interface matches intended VMnet | All four VMware MACs recorded; WAN shown as NAT and reported as VMnet8; guest matching pending | E02/E03 |
| FW01 addresses | WAN DHCP; internal .1/24 addresses | Pass: displayed addresses match the plan | E04 |
| Guest gateway reachability | Guest reaches its local gateway | Pass: 10.10.10.1 replied 4/4, 0% loss | E05 |
| Management access from DC01 | Authenticated pfSense dashboard from 10.10.10.10 | Pass: dashboard displays admin@10.10.10.10 | E07 |
| Upstream connectivity | External IPv4 endpoint reachable | Pass: 1.1.1.1 replied 4/4, 0% loss, average 21 ms | E05 |
| DNS resolution | pfSense answers query for example.com | Pass: 10.10.10.1 returned A and AAAA records | E05 |

Additional evidence: E08 shows WAN em0 enabled, IPv4 DHCP, IPv6 DHCP6, and configured MAC override matching the recorded VMware WAN MAC. Private-network filtering checkboxes are outside the capture. E09 shows SERVERS DHCP enable unchecked; displayed inactive range 10.10.10.10–10.10.10.245 overlaps static server addresses and must not be enabled. OFFICE/OT DHCP status remains pending.

Subsequent E10 capture supplied for WAN shows private-network blocking unchecked and bogon blocking checked. E11–E13 show enabled internal interfaces, correct .1/24 static addresses, IPv6 None, upstream gateway None, and private/bogon blocking unchecked. These are interface settings, not DHCP server pages; OFFICE/OT DHCP status remains unverified. Saved-state confirmation is not visible in these forms.

Address configuration does not demonstrate firewall isolation. Allowed and denied cross-network traffic will be tested in a separate policy ticket.

## Documentation and Git

Architecture, build log, and screenshot checklist created. Screenshot files and commit reference pending. Ticket remains open until required validation is complete.
