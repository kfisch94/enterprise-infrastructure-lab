# LAB-005 — Windows DHCP for the OFFICE subnet

**Owner:** Kyle Fischer\
**Opened:** October 6, 2026\
**Status:** In progress; server readiness and client DHCP lease validated; relay/rule/server-lease evidence pending

## Request

Provide automatic addressing for OFFICE clients through Windows DHCP on DC01, relayed by pfSense across the routed subnets.

## Scope plan

| Setting | Value |
|---|---|
| DHCP server | DC01.corp.fischerlab.test / 10.10.10.10 |
| Scope name | OFFICE - Employee Workstations |
| Scope subnet | 10.10.20.0/24 |
| Lease range | 10.10.20.100–10.10.20.199 |
| Exclusions | None needed within this range at present |
| Lease duration | Wizard default 8 days |
| Option 003 Router | 10.10.20.1 |
| Option 006 DNS | 10.10.10.10 only |
| Option 015 DNS domain | corp.fischerlab.test |
| WINS | None |
| Relay interface | OFFICE only |
| Relay destination | 10.10.10.10 |

Gateway .1 and temporary client .50 are outside the lease pool. Do not change DC01's static address or enable a SERVERS lease pool. VMware VMnet8 DHCP stays enabled for FW01 WAN.

## Implementation sequence

1. Install DHCP role and management tools on DC01.
2. Complete DHCP post-install configuration and AD authorization; verify authorization.
3. Create and activate the OFFICE scope and options.
4. Confirm pfSense DHCP server disabled on all internal interfaces, then enable IPv4 relay on OFFICE to DC01.
5. Review relay traffic and DHCP firewall handling; validate actual lease acquisition.
6. Adapt OFFICE domain-access rule from static source .50 to the documented DHCP-client source policy before testing enrollment.
7. Switch CLIENT01 to automatic IP and DNS, renew lease, and capture client and server evidence.

## Validation

E01 verifies successful installation with no restart required. E02 verifies pool 10.10.20.100–10.10.20.199 and actual scope label OFFICE. E03 verifies option names 003/006/015 but values are outside capture. Scope activation, service status, and AD authorization are not yet verified; a red downward indicator on IPv4 warrants checking status. No client lease has been captured.

Subsequent E04 verifies all three option values against the plan: router 10.10.20.1, DNS 10.10.10.10, and suffix corp.fischerlab.test. No further option query is needed for this checkpoint.

E05 verifies DHCPServer Running, DC01 authorization at 10.10.10.10, and Active OFFICE scope 10.10.20.0 with /24 mask and expected pool. Next requested steps: pfSense internal DHCP servers off; IPv4 relay enabled on OFFICE only to 10.10.10.10; update temporary OFFICE-to-DC01 access rule source to OFFICE net and description to TEMP - OFFICE clients to DC01 for domain enrollment. Then set CLIENT01 IPv4 and DNS automatic, renew, and capture client ipconfig plus Windows lease list. These next steps are not yet reported complete.

Pending DHCP install result, authorization, active scope, options, relay settings, CLIENT01 DHCP-enabled output, DHCP server 10.10.10.10, address in expected pool, correct gateway/DNS/suffix, and matching Windows DHCP lease record. DNS/TCP connectivity must be retested from the leased address.

## Troubleshooting / Git

E06 validates CLIENT01 lease 10.10.20.100/24 from DHCP server 10.10.10.10 with expected gateway, DNS, suffix, DHCP enabled, and eight-day lease timestamps. Network service works for the captured acquisition. Actual relay configuration and applied rule changes are not yet supplied; collect them and the matching Windows lease entry for complete configuration evidence. Retest DNS/TCP from the new address before enrollment.

Subsequent LAB-007 E19 corroborates OFFICE net source on the DC01 bootstrap rule; LAB-007 E20 verifies SMB connectivity from DHCP lease 10.10.20.100 to FS01. Relay settings and Windows DHCP lease table remain outstanding documentation items.

Pending. Current client static connectivity is verified under LAB-004; it is not evidence of DHCP success.

## References

- [Microsoft DHCP quickstart](https://learn.microsoft.com/en-us/windows-server/networking/technologies/dhcp/quickstart-install-configure-dhcp-server)
- [Netgate DHCP relay](https://docs.netgate.com/pfsense/en/latest/services/dhcp/relay.html)
