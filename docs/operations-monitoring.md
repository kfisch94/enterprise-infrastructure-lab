# OPS01 monitoring runbook

## Verified deployment

Ubuntu OPS01 uses 10.10.10.30/24 on VMnet2, gateway10.10.10.1 and DNS10.10.10.10. CLIENT01's OFFICE DHCP address10.10.20.100 is reserved on DC01. pfSense and UFW permit SSH TCP22 from that address. All files below are guest paths, not host portfolio paths.

The collector `/home/kf/fischerlab-health/collect-health.py` writes an atomic latest snapshot to `health.json`. `fischerlab-health.timer` invokes an unprivileged oneshot service approximately every minute (60-second interval, 5-second accuracy). The dashboard service runs as kf, serves only `/` and `/api/health`, and listens on127.0.0.1:8080. It is intended for this isolated personal lab. It is not a production monitoring platform.

## Access from CLIENT01

In Windows PowerShell, open a management session:

```powershell
ssh kf@10.10.10.30
```

In a separate PowerShell tab, establish the dashboard tunnel and keep the tab open:

```powershell
ssh -N -L 8080:127.0.0.1:8080 kf@10.10.10.30
```

Open `http://127.0.0.1:8080` in CLIENT01's browser. Re-establish both SSH sessions after a reboot. Credentials are entered interactively, never stored in these scripts. Independent host-key comparison was requested but is not captured in the evidence.

## Interpretation

Host cards show uptime, memory consumption, root filesystem usage and one-minute load average. Six checks cover the DC01 DNS record, external example.com resolution, DC01 TCP53 and TCP389, FS01 TCP445 and local OPS01 SSH TCP22. DNS and TCP results do not prove authenticated AD or SMB health.

The collector labels the snapshot healthy when all checks pass, root disk use is below85%, and memory use is below90%. Otherwise it reports attention. The dashboard refreshes every15 seconds and marks a snapshot older than180 seconds stale. Retained PASS entries in a stale view refer to historical observations. Data is latest-snapshot only; history and notifications are not implemented.

## Diagnose on OPS01

```bash
systemctl list-timers fischerlab-health.timer --no-pager
systemctl status fischerlab-dashboard.service --no-pager
sudo journalctl -u fischerlab-health.service -n 15 --no-pager
sudo journalctl -u fischerlab-dashboard.service -n 15 --no-pager
sudo ss -ltnp | grep ':8080'
jq '{collected_at, hostname, status}' ~/fischerlab-health/health.json
curl -fsS http://127.0.0.1:8080/api/health | jq .
```

Successful oneshot collection ends in service deactivation; this is expected. Check the timer and journal for recurring successful runs. On first startup, systemctl active may precede socket readiness; the dashboard setup probe retries connection refusals. Verification warnings referencing distribution XFS units' obsolete CPUAccounting settings did not prevent these lab units from working.

## Completed validation

- Static networking and SSH survive reboot.
- UFW remains active; a fresh restricted-source SSH login succeeds.
- Recurring collector runs generate fresh snapshots.
- Dashboard displays all six passing checks through SSH.
- Deliberately pausing collection produces a stale warning at187 seconds; resumed collection clears it.
- Final reboot starts timer and dashboard automatically, retains UFW, and produces fresh data; listener is loopback-only.

See [LAB-009](../tickets/009-ubuntu-operations-server.md) and its [screenshots](../evidence/009-ubuntu-operations-server/README.md). Backup/restore, SSH key authentication, denied-source testing and deferred phased updates are follow-up work. No Git commits or publication have been performed.
