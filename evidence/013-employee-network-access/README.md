# LAB-013 evidence — Employee network access

- `001-private-networks-alias-form.png`: PRIVATE_NETWORKS Network(s) alias form contains all three RFC1918 ranges correctly. Save/application not established by form alone.

- `002-office-web-rule-applied.png`: Successful apply banner; enabled OFFICE IPv4 TCP web rule to inverted PRIVATE_NETWORKS/WEB_TCP; existing exceptions and disabled bootstrap rule retained.

- `003-dns-resolver-baseline.png`: Resolver enabled, port53/All interfaces, DNSSEC on, forwarding/Python module off. No settings changed.
- `004-client-web-private-access-checks.png`: HTTPS 200, FW01 private TCP443 false, restricted OPS01 SSH true and mapped file readable.
- `005-client-browser-https.png`: Edge loads external HTTPS page, corroborating browser access.

- `006-pfblocker-package-availability.png`: Both package variants offered as 3.2.17_1; standard pfBlockerNG selected, installation not yet evidenced.

- `007-pfblocker-wizard-ip-step.png`: Package wizard available; WAN inbound/SERVERS outbound defaults visible. Final wizard application not captured; manual DNS-only configuration chosen.

- `008-dc-dns-forwarder.png`: DC01 forwarder 10.10.10.1 verified, root-hint fallback True.
- `009-pfblocker-wizard-exit.png`: Components/default warnings and Here exit link visible; completion not performed in evidence.

- `010-pfblocker-general-manual-baseline.png`: Manual General page; master Enable off, Keep Settings on, hourly CRON and displayed log defaults.

- `011-dnsbl-disabled-baseline.png`: DNSBL off/Unbound mode, Localhost, empty VIP, permit rules off, No Global mode and resolver cache on. Source confirms configured VIP prerequisite.

- `012-dnsbl-vip-selected-enable-form.png`: Enable checked, Localhost VIP 10.10.40.1 selected, Unbound mode; automatic permits and DNSBL IP action off. Save/runtime filtering not evidenced.

- `013-dnsbl-group-editor-baseline.png`: Blank group editor defaults; custom test group and update/reload not yet evidenced.

- `014-dnsbl-reload-two-entries.png`: Reload/update process ends successfully, two DNSBL entries, Unbound restarted, no firewall-rule/alias changes. Remote feed retrieval not established.

- `015-hagezi-feed-download-build-success.png`: HaGeZi feed downloads HTTP200, 239,206 entries; combined DNSBL 239,208 PASSED, Unbound restarted, no rule/alias changes.

- `016-client-filtering-ad-file-pass.png`: CLIENT01 gets null block for example.org through DC01; allowed public DNS, AD SRV and mapped file pass.
- `017-dc-cache-clear-direct-filter-pass.png`: DC DNS cache cleared and direct FW01 query returns null block.

- `018-edge-managed-dns-policy.png`: Mandatory device DnsOverHttpsMode off, status OK, applied in Edge.
- `019-direct-external-dns-fails.png`: CLIENT01 direct external DNS query times out and TCP53 test false; gateway log not supplied.

- `020-blocked-domain-aaaa-no-output.png`: Blocked example.org AAAA query completes with no visible records.
- `021-filtering-dashboard-resources.png`: Groups/counts active; FW memory35%, CPU4%, disk7%, swap0%, interfaces up.
- `022-dnsbl-groups-schedule.png`: Both groups Unbound/global null/no logging; custom Never, threat feed Once a day.

- `023-filtering-backup-properties.png`: New private 49,107-byte configuration checkpoint, earlier four retained.
- `024-browser-custom-domain-blocked.png`: Edge example.org fails ERR_ADDRESS_INVALID.
- `025-browser-allowed-domain-loads.png`: Edge allowed example.com HTTPS loads.
- `026-filtering-backup-metadata.txt`: Final size/hash/encrypted-format verification; backup contents/password excluded.

Scoped milestone complete; restore of this checkpoint not tested. Suricata is tracked separately. Do not claim a subnet web rule establishes per-user identity authorization or blocks every encrypted DNS/VPN bypass.
