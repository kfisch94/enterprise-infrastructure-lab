# LAB-014 evidence — Suricata intrusion detection

- `001-fw-4gb-reboot-dashboard.png`: FW01 2.9.0 reboot,4035MiB RAM/two CPUs, expected interfaces and DNSBL counts retained.
- `002-suricata-package-offer.png`: GUI package7.0.9_1 offered; engine dependency8.0.5_1 shown. Install not yet evidenced.

- `003-suricata-installed-packages.png`: Current Suricata GUI package7.0.9_1 and engine dependency8.0.5_1 installed; pfBlockerNG retained. Bottom warning descriptions are a legend.
- `004-suricata-empty-interface-list.png`: Suricata UI accessible; no interface sensor configured yet.

- `005-global-rule-source-defaults.png`: Rule sources off, update NEVER/start00:25, live swap/GeoIP/system-log copy off, keep settings on.

- `006-et-open-update-success.png`: ET Open MD5/date installed; manual update success, other rule sources Not Enabled.

- `007-office-interface-form-upper.png`: OFFICE/em2 selected, Enable checked in unsaved form, Block Offenders off, default engine settings; lower network definitions cut off.

- `008-office-network-defaults-form.png`: Home/External Net defaults, suppression default, advanced field empty; explicit lab Home Net pending.

- `009-disabled-new-interface-save-errors.png`: New-interface save fails numeric validation after Enable unchecked.
- `010-disabled-form-empty-max-packets.png`: Disabled form has empty Max Pending Packets/profileLow; no saved instance proven.
- `011-disabled-form-empty-snaplen.png`: Disabled numeric/network controls, empty Snaplen/recursion, promiscuous off/HomeNetdefault.

- `012-hardware-offload-warning.png`: Suricata warns checksum/TSO/LRO not all disabled; WAN heading visible but binding/status not established.

- `013-office-sensor-saved-stopped.png`: Saved OFFICE (em2) instance, red stopped status with start control, pattern match AUTO, blocking DISABLED, description OFFICE. Confirms binding despite previous WAN heading; hardware-offload settings themselves not shown.

- `014-office-categories-before-selection.png`: OFFICE Categories shows Resolve Flowbits checked, visible built-in event categories enabled, and visible ET Open categories unchecked. Lower categories are outside capture; no selection or runtime inferred.

- `015-test-signature-enabled.png`: Cropped rule row shows enabled green status for SID 2100498, GPL ATTACK_RESPONSE id check returned root. User also explicitly reports verification of the offloading settings; configuration screenshot not supplied.

- `016-home-net-membership.png`: HOME_NET view includes all three internal /24 networks, DNSBL VIP 10.10.40.1/32, loopback, VMware gateway/WAN /32 addresses, and IPv6 local /128 entries. Default membership accepted for this initial OFFICE sensor; no custom list required.

- `017-office-stats-settings.png`: OFFICE/em2 enabled form, statistics enabled at 10 seconds, standalone HTTP/TLS/file/packet logs off.
- `018-eve-default-logging-options.png`: EVE FILE/alerts enabled; payload BOTH, packet dump and numerous protocol/extended logs on, Perf Stats off. Captures pre-adjustment form, not final saved logging.
- `019-office-alert-only-engine-settings.png`: Block Offenders off, AutoFP/Hash, 1024 pending packets, Medium profile, automatic matchers.
- `020-office-network-engine-settings.png`: Recursion 3000, promiscuous on, snaplen1518, default Home/External Net and suppression, advanced passthrough empty; Save visible.

- `021-office-sensor-running.png`: OFFICE/em2 green running status, AUTO matching and blocking DISABLED.
- `022-test-host-dns-failure.png`: CLIENT curl for testmynids.org fails with error6/could not resolve host, before HTTP test traffic.
- `023-office-alerts-empty-after-dns-failure.png`: OFFICE alerts empty following failed DNS test; does not establish a detection failure.

- `024-test-dns-diagnostics.png`: CLIENT resolves example.com via DC01 to public A records, testmynids.org via DC01 returns DNS name error, direct query to FW01 times out. General DC-mediated DNS works; test hostname root cause not established. Direct firewall timeout is consistent with the configured OFFICE DNS restrictions.

- `025-benign-signature-alert.png`: OFFICE alert at 10/08/2026 20:15:34, UDP CLIENT01 10.10.20.100:49522 to DC01 10.10.10.10:123, GID:SID1:2100498, priority2, GPL ATTACK_RESPONSE id check returned root. Controlled benign test payload matched; not evidence of compromise.

- `026-running-ids-smoke-smb-failure.png`: Benign UDP test sends23 bytes; example.com resolves A/AAAA, example.org A0.0.0.0, IPv4 HTTPS200. CLIENT10.10.20.100 -> FS01 10.10.10.20 TCP445 fails; ping timeout also shown. SMB failure unresolved, no IDS causality established.
- `027-log-management-defaults.png`: Auto Log Management off, directory limit off/default3044MB, alert500KB/14days, eve-json5MB/7days.
- `028-log-retention-lower-settings.png`: Stats500KB/7days, TLS500KB/14days; file/cert/pcap retention defaults. Captures pre-adjustment form.

- `029-fs01-address-smb-listener.png`: FS01 Ethernet0 IPv4 10.10.10.20, LanmanServer running, TCP445 listening on ::. Confirms powered guest/service/listener, not remote IPv4 reachability or firewall acceptance.

- `030-historical-smb-firewall-log.png`: OFFICE default-deny entries for CLIENT -> FS01 TCP445 dated04:43,04:53 and19:06–19:07, TCP PA/RA flags. Historical established-connection packets; not fresh SYN attribution for the earlier smoke failure.
- `031-fs01-domain-profile-rule-query.png`: Ethernet0 DomainAuthenticated; queried FPS-SMB-In-TCP rule disabled and scoped Private/Public. This query does not enumerate all effective domain SMB permissions.
- `032-client-fs01-smb-retry-passed.png`: CLIENT10.10.20.100 -> FS01 10.10.10.20 TCP445 retry True. No configuration change supplied; earlier failure cause remains unknown.

- `033-log-management-enabled-512mb.png`: Auto Log Management and directory cap enabled,512MB entered; supplied as saved-settings evidence. Actual rotation/cap execution untested.
- `034-amelia-it-share-access.png`: IT Department I: listing includes restore-validation41bytes; user confirms amelia still has access. Logged-in identity/file-open contents not independently shown.

- `035-post-ids-private-backup.png`: New85,617byte configuration checkpoint in private FW01 backup folder, older copies retained.
- `036-backup-metadata.txt`: Read-only SHA256 and encrypted-format marker inspection; payload/password excluded.

Scoped initial IDS milestone complete. Benign signature detection, normal DNS, configured DNS block, IPv4 HTTPS, fresh SMB TCP connectivity and user-confirmed IT share access verified while IDS active. Earlier transient SMB failure retained without root-cause claim. Log management/cap configured and new encrypted checkpoint saved. Rotation execution, schedule corroboration, full saved category selection, final reduced EVE logging/statistics, reboot persistence and restore of the new checkpoint remain untested.
