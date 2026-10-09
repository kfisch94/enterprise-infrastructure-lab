# LAB-002 — Deploy Active Directory and domain DNS

**Owner:** Kyle Fischer\
**Opened:** October 6, 2026\
**Status:** In progress; AD identity and basic DNS validation passed; remaining health checks pending

## Request

Provide central identity and DNS for domain users and computers in the lab.

## Plan

1. Verify actual guest computer name, operating system, and current domain membership; VMware display name does not establish Windows hostname.
2. Confirm guest is a standalone server, rename to DC01 if needed, and reboot before promotion.
3. Install AD DS and management tools.
4. Choose and document the isolated lab forest namespace, then promote with DNS installed.
5. Revise DC01 DNS settings, configure forwarding, and validate AD/DNS health.
6. Join CLIENT01 after the required firewall rules exist.

Selected isolated lab namespace: corp.fischerlab.test; planned NetBIOS name FISCHERLAB. This is a lab-only namespace, not a claimed registered public domain. Kyle reports the restart completed after promotion instructions. Screenshot E03 shows DC01.corp.fischerlab.test, domain corp.fischerlab.test, and AD DS / DNS in Server Manager. Functional level, actual NetBIOS name, AD service health, SYSVOL, and DNS validation remain pending.

## Implementation and validation

Preflight identity and OS checks passed; see [evidence](../evidence/002-active-directory/README.md). Next requested step: Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools, followed by Get-WindowsFeature AD-Domain-Services. Role result and promotion remain pending. Capture promotion prerequisite checks without passwords and post-reboot AD/DNS validation. Do not label role installation as successful domain-controller promotion.

## Failure / troubleshooting

Role installation evidence E02 shows Success=True, Restart Needed=No, Exit Code=Success. Get-WindowsFeature reports AD-Domain-Services Installed. Forest creation, DNS installation, and promotion validation remain pending.

Next requested wizard settings: new forest corp.fischerlab.test; Windows Server 2016 forest/domain functional levels for this Server 2022 lab; DNS and Global Catalog enabled; RODC disabled; privately stored DSRM password; no DNS delegation; NetBIOS FISCHERLAB; default database/log/SYSVOL paths. Capture prerequisite results before clicking Install. Do not publish passwords or generated scripts containing secrets.

None reported.

E04–E06 verify NetBIOS FISCHERLAB, Windows2016Domain, running NTDS/DNS/Netlogon, host and LDAP SRV records, external resolution through DC01, and dcdiag Connectivity/basic DNS passes. Forwarder 10.10.10.1 is displayed. Preferred adapter DNS, forest functional level, Advertising/SYSVOL checks, and reverse-DNS cleanup remain pending. nslookup Server: Unknown is a reverse-name observation; forward queries succeeded.

## Git commit

Next requested configuration: DC01 preferred IPv4 DNS 10.10.10.10 with alternate blank; DNS server forwarder 10.10.10.1. Both requested, not verified. Capture domain query, service status, internal host and SRV lookups, external resolution through DC01, and dcdiag DNS results.

Pending.

## Reference

[Microsoft AD DS installation guide](https://learn.microsoft.com/windows-server/identity/ad-ds/deploy/install-active-directory-domain-services--level-100-)
