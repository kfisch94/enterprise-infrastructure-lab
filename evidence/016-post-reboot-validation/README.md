# LAB-016 evidence

- `001-client-post-reboot-checks-ssh-failed.png`: CLIENT employee identity/Office addressing, DNS block, IPv4 HTTPS200, FS01 file read and both gpupdate checks pass; OPS01 TCP22 fails. DNS server not shown by standard ipconfig.
- `002-suricata-post-reboot-running.png`: OFFICE/em2 running, AUTO matching/blocking DISABLED after user-reported all-VM reboot. No boot logs or new signature test yet.

- `003-ops01-services-ssh-login-recovered.png`: Correct ens33/route, SSH service/socket active+enabled; accepted kf SSH login fromCLIENT10.10.20.100 at02:00:06UTC. SSH listeners and loopback-only dashboard listener present, monitoring timer/dashboard active. Earlier SSH failure cause not established.

- `004-fresh-post-reboot-health-dashboard.png`: CLIENT localhost dashboard snapshot6seconds old at02:07:11.641UTC Oct9, six checks PASS; OPS01 uptime8min, memory10.9%, root30.5%, load0.00.
- `005-fw-post-reboot-resources-dnsbl.png`: FW uptime18m39s, interfaces up, memory21%of4035MiB/swap0%, CPU2%, root8%; DNSBL counts retained.

- `006-post-reboot-test-packet-sent.png`: Single benign UDP signature payload sent to DC01:123, Send returns23bytes; resulting alert not shown.
- `007-fw-resources-second-observation.png`: FW uptime23m38s at02:13:12UTC, CPU2%, memory21%/swap0%, interfaces and DNSBL counts retained. Main dashboard does not show Suricata alert or account state.

- `008-post-reboot-signature-alert.png`: New OFFICE SID2100498 atOct9 02:11:01UTC, CLIENT10.10.20.100:62252 ->DC01:123 UDP; expected benign test alert.
- `009-disabled-account-state-retained.png`: DC01 offboard.test EnabledFalse/MemberOf{} after reported reboot.

Scoped post-reboot validation complete: core client services, OPS01 authenticated SSH/service recovery, fresh monitoring/resource observations, new IDS signature alert and retained disabled-account state. Earlier SSH failure retained without proven cause. No HA/load test, exhaustive domain audit, new backup restore, scheduled update/rotation execution or fresh post-reboot disabled-account authentication retest claimed.
