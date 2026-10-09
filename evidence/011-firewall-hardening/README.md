# LAB-011 evidence — Firewall hardening

Final milestone: scoped firewall rules and controlled OFFICE/OT denied-path tests complete; temporary resources removed and CLIENT01 restored. Captions below describe each historical checkpoint, including problems subsequently resolved. No exhaustive protocol/production OT claim.

- `050-ops-outbound-ipv4-ntp-pass.png`: Fresh IPv4 UDP123 query to Cloudflare receives valid48-byte mode4 response, stratum3. Reachability verified; no clock configuration changed.

- `049-restored-office-employee-policy-drive-pass.png`: Final Amelia policy update succeeds, department-drive GPO applied from DC0115:32:33, mapped IT file reads correctly after OT cleanup/OFFICE restoration.

- `047-ot-test-listener-cleanup.png`: Original OT listener and exact temporary host rule removed successfully; both presence checks False.
- `048-client-office-dhcp-restored.png`: DHCP/DNS and primary registration restored; CLIENT01 Preferred10.10.20.100, correct OFFICE gateway/DC DHCP/DNS/suffix, renewed15:31:12. Final employee policy/mapped-drive check pending.

- `045-verified-ot-listener-repeat-block-log.png`: New5 SYN blocks22:28:21–25UTC OPS01 sourceport37426 to OT8443 under named rule, after proven local listener baseline; older5 entries also visible.
- `046-ops-repeat-dc-pass-verified-ot-timeout.png`: Repeat DC01445 success and verified OT8443 timeout. Controlled test complete; cleanup/restoration pending.

- `044-ot-listener-local-positive-baseline.png`: Temporary OT listener10.10.30.100:8443 Listen PID7580, scoped OPS01 host exception enabled, local TCP test True. Repeat OPS01 attempt/new gateway log before cleanup.

- `043-ot-listener-baseline-failed-no-rule.png`: Local OT TCP8443 False, listener variable null and exact host rule absent; both presence checks False. Gateway block logs remain valid, but known-listening-target OT validation must be repeated. OFFICE restoration pending.

- `040-servers-to-ot-block-log.png`:5 named SERVERS-to-OT blocked SYNs OPS01 .30 to temporary OT .100:8443, tracker1791409531.
- `041-ot-to-dc-smb-default-deny-log.png`:5 OT default-deny SYNs temporary endpoint10.10.30.100 to DC01:445, tracker1000000103.
- `042-ops-dc-smb-pass-ot-listener-timeout.png`: OPS01 reaches DC01:445 and times out to OT:8443. OT local listener baseline, cleanup and CLIENT01 restoration pending.

- `039-client-ot-ip-preferred.png`: Temporary OT endpoint10.10.30.100/24 reaches Preferred state; traffic tests ready.

- `037-client-temporary-ot-vmnet4.png`: VMware adapter custom VMnet4 connected; temporary simulated OT endpoint setup.
- `038-client-temporary-ot-ip-tentative.png`: Ethernet0 static10.10.30.100/24 gateway10.10.30.1, DHCP disabled; IPv4 Tentative at capture. Address readiness and OT traffic tests pending.

- `036-office-test-listener-cleanup.png`: Original CLIENT01 listener stopped and exact temporary Windows firewall exception removed; both presence checks False. SERVERS-to-OFFICE denial and cleanup complete.

- `035-servers-to-office-block-log.png`:5 blocked SERVERS TCP SYNs from OPS01 .30:45616 to CLIENT01 .100:8443 match named SERVERS-to-OFFICE block, tracker1791409491. Gateway denial verified; temporary listener/host-rule cleanup pending.

- `034-office-listener-baseline-ops-timeout-ipv4-web-pass.png`: CLIENT01 local8443 listener test True and scoped Windows allowance created; OPS01 IPv4 HTTPS200 and connection to CLIENT018443 timed out. pfSense block attribution and cleanup pending.

- `033-ops-gateway-dns-web-repositories-pass.png`: OPS01 uptime14min, gateway3/3 ping replies, DC01 resolves10.10.10.10, external name resolves, HTTPS200 and apt metadata refresh successful;2 available upgrades. Reboot/reconnection and actual HTTPS IP family not directly captured.

- `031-fresh-client-user-policy-success.png`: amelia user gpupdate completes successfully; gpresult confirms department-drive GPO from DC01 applied15:01:44, correct IT OU/groups and no slow link. Fresh session requested after prior timeout; reboot itself not pictured.
- `032-fresh-client-mapped-it-file-read.png`: Mapped I: restored-file read succeeds after successful policy retry. Original stall cause unproven; OPS01/further segmentation tests pending.

- `030-original-policy-timeout-mapped-read-pass.png`: Original user gpupdate times out; mapped IT restored file read succeeds. Restart comparison not yet captured.

- `027-policy-events-refresh-request-only.png`: Elevated log latest event14:50:05 refresh attribution for amelia; older service initialization/session successes14:13. Current completion not shown.
- `028-policy-events-older-drive-map-success.png`: Historical14:03:50 user manual policy and drive-map success; does not validate current request.
- `029-original-policy-update-still-waiting.png`: Original gpupdate remains at Updating policy. Root cause unresolved; fresh CLIENT01 restart test next.

- `026-client-sysvol-share-pass-event-access-denied.png`: amelia TCP445 to DC01 True, SYSVOL directory listing and restored IT UNC read pass. Operational event-log query denied under standard account; policy update completion still pending.

- `025-client-user-policy-waiting.png`: User reports policy update stalled;14:55 capture still shows Updating policy, no success/error. Investigation pending after SERVERS rule changes.

- `024-client-lease-dns-discovery-after-servers-hardening.png`: CLIENT01 DHCP enabled, new lease timestamp14:50:04, address10.10.20.100/24, gateway10.10.20.1, DHCP/DNS10.10.10.10 and correct suffix. External example.com resolution and forced DC discovery succeed. Release command not visible; user GPO update still running at capture; mapped-file read not shown.

- `023-servers-default-allows-disabled.png`: Apply success; ICMP echoreq corrected; both default allows disabled, anti-lockout retained. Old IPv4 default still shows1state; fresh functional and blocked-path tests pending.

- `022-servers-blocks-and-rule-order.png`: Apply success; DHCP/DNS/gateway ICMP before logged OFFICE/OT blocks, followed by NTP/web then enabled defaults. Gateway ICMP shows inforeq rather than desired echoreq; correction needed. DNS5KiB/4states and web32KiB visible; restricted-policy tests pending.

- `020-web-port-alias-form.png`: WEB_TCP port alias form with separate80/443 entries; save/apply not shown in form.
- `021-servers-egress-rules-below-defaults.png`: Apply success banner; correct DNS, gateway ICMP, NTP and WEB_TCP pass entries, but placed below default allow-all. Must reorder before validation; no restricted egress claim.

- `019-servers-dhcp-rules-ordered.png`: Both DHCP pass rules enabled above default IPv4/IPv6 allow-all; anti-lockout retained. DHCP counters0B; no post-hardening DHCP test yet. Apply confirmation banner is outside this capture.

- `017-servers-dhcp-relay-rule-form.png`: Enabled SERVERS IPv4 UDP pass form, DC01 source10.10.10.10 port67 to This Firewall port67; correct description. Saved/applied state and order not shown.
- `018-servers-dhcp-client-rule-form.png`: Enabled SERVERS IPv4 UDP pass form, DC01 source10.10.10.10 port67 to OFFICE net port68; correct description. Saved/applied state and order not shown.

- `016-office-dhcp-relay-settings.png`: Relay enabled; OFFICE selected; destination DC0110.10.10.10; CARP none and circuit/agent ID unchecked. Confirms previously inferred relay configuration.

- `014-office-default-deny-test-log.png`:5 OFFICE default-deny IPv4 entries, CLIENT01 .100:63061 to DC01 .10:8443 TCP SYNs; gateway filtering confirmed.
- `015-controlled-listener-cleanup.png`: Listener and temporary Windows host exception removed; both presence checks False. OFFICE hardening milestone complete; SERVERS/OT still pending.

- `012-dc01-controlled-listener.png`: Temporary DC01 TCP8443 listener and scoped host firewall rule created; listener shown.
- `013-ops-allowed-client-tcp-denied.png`: OPS01 reaches known listener; CLIENT01 .100 TCP8443 fails but ping succeeds. Gateway block-log attribution and cleanup pending.

- `010-dhcp-renewal-and-dc-time-query.png`: CLIENT01 .100 lease renewed with correct DNS/router/suffix;3 DC01 UDP123 time responses, offset about1.57s.
- `011-replacement-rule-traffic-counters.png`: DHCP/AD TCP/AD UDP/SMB counters increase; TEMP disabled0B. ICMP rule not yet exercised; blocked-path validation pending.

- `007-office-temp-disabled.png`: Applied TEMP rule disabled; explicit replacement and SSH/SMB pass rules retained.
- `008-client-dns-discovery-policy-kerberos.png`: amelia identity, DC01 DNS/forced discovery, successful user GPO refresh and Kerberos TGTs.
- `009-kerberos-services-mapped-file-read.png`: LDAP/CIFS service tickets and restored IT file read via mapped I:. DHCP/time and blocked-path tests pending.

- `006-office-replacement-rules-staged.png`: Applied ICMP echo, DHCP UDP67 and AD UDP/TCP alias rules above existing SSH/SMB/TEMP rules. TEMP remains enabled; new rule counters zero, so restricted-policy behavior is not yet tested.

- `005-ad-port-aliases-applied.png`: Applied TCP/UDP AD aliases with expected port lists and overall descriptions. Rules not yet replaced.

- `001-wan-rules-baseline.png`: WAN bogon block and no user interface rules shown.
- `002-servers-rules-baseline.png`: SERVERS anti-lockout and default IPv4/IPv6 allow-all rules.
- `003-office-rules-baseline.png`: Restricted SSH, department SMB and temporary any-IPv4 access to DC01.
- `004-ot-rules-baseline.png`: OT interface has no rules. No traffic isolation test performed; SERVERS allow-all remains.

OFFICE/SERVERS rules and scoped allowed/denied tests are captured through E50. Floating/NAT configuration not captured; configuration recovery/version review remain follow-up work.
