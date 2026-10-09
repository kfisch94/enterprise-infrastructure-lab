# Run in the OPS01 SSH session after the first collector succeeds.
# The service runs as kf; sudo only installs and activates the system units.
sudo tee /etc/systemd/system/fischerlab-health.service >/dev/null <<'SERVICE'
[Unit]
Description=FischerLab host metrics and endpoint reachability snapshot
Wants=network-online.target
After=network-online.target

[Service]
Type=oneshot
User=kf
Group=kf
WorkingDirectory=/home/kf/fischerlab-health
ExecStart=/usr/bin/python3 /home/kf/fischerlab-health/collect-health.py --output /home/kf/fischerlab-health/health.json
TimeoutStartSec=60
UMask=0077
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
ProtectHome=read-only
ReadWritePaths=/home/kf/fischerlab-health
SERVICE

sudo tee /etc/systemd/system/fischerlab-health.timer >/dev/null <<'TIMER'
[Unit]
Description=Collect FischerLab health every minute

[Timer]
OnBootSec=30s
OnUnitActiveSec=60s
AccuracySec=5s
Unit=fischerlab-health.service

[Install]
WantedBy=timers.target
TIMER

sudo systemd-analyze verify /etc/systemd/system/fischerlab-health.service /etc/systemd/system/fischerlab-health.timer
sudo systemctl daemon-reload
sudo systemctl start fischerlab-health.service
sudo systemctl enable --now fischerlab-health.timer
systemctl list-timers fischerlab-health.timer --no-pager
sudo journalctl -u fischerlab-health.service -n 10 --no-pager
jq '{collected_at, hostname, status}' ~/fischerlab-health/health.json
