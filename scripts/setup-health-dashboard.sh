cat > ~/fischerlab-health/health-dashboard.py <<'PYTHON'
#!/usr/bin/env python3
"""Read-only lab dashboard; expose only on loopback through an SSH tunnel."""
import argparse
import json
from pathlib import Path
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer


def handler_for(directory):
    class Handler(BaseHTTPRequestHandler):
        def do_GET(self):
            route = self.path.split('?', 1)[0]
            if route == '/':
                source, mime = directory / 'dashboard.html', 'text/html; charset=utf-8'
            elif route == '/api/health':
                source, mime = directory / 'health.json', 'application/json'
            else:
                self.send_error(404)
                return
            try:
                body = source.read_bytes()
                if route == '/api/health':
                    json.loads(body)
            except (OSError, ValueError):
                self.send_error(503, 'Snapshot or dashboard unavailable')
                return
            self.send_response(200)
            self.send_header('Content-Type', mime)
            self.send_header('Content-Length', str(len(body)))
            self.send_header('Cache-Control', 'no-store')
            self.send_header('X-Content-Type-Options', 'nosniff')
            self.send_header('X-Frame-Options', 'DENY')
            self.send_header('Content-Security-Policy', "default-src 'self'; script-src 'unsafe-inline'; style-src 'unsafe-inline'; connect-src 'self'; frame-ancestors 'none'; base-uri 'none'")
            self.end_headers()
            self.wfile.write(body)
    return Handler


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, default=Path(__file__).resolve().parent)
    parser.add_argument('--port', type=int, default=8080)
    args = parser.parse_args()
    server = ThreadingHTTPServer(('127.0.0.1', args.port), handler_for(args.directory))
    print(f'FischerLab dashboard listening on 127.0.0.1:{args.port}', flush=True)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()
PYTHON
cat > ~/fischerlab-health/dashboard.html <<'HTML'
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>FischerLab | Operations</title>
<style>
:root{color-scheme:dark;font-family:Segoe UI,system-ui,sans-serif;background:#101820;color:#e9f0f4}
*{box-sizing:border-box}body{margin:0}main{max-width:1080px;margin:0 auto;padding:42px 24px}
.eyebrow{color:#64d8c0;font-size:13px;letter-spacing:2px;text-transform:uppercase}h1{font-size:38px;margin:10px 0}p{color:#b0c0cc;line-height:1.6}
.top{display:flex;justify-content:space-between;align-items:center;gap:20px}.badge{padding:10px 16px;border-radius:24px;background:#243342;font-weight:600}
.good{background:#163f37;color:#91efc9}.bad{background:#493326;color:#ffcc95}.grid{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin:28px 0}
.card{background:#1a2631;border:1px solid #2c3b47;border-radius:14px;padding:22px}.label{font-size:13px;color:#adbecb}.value{font-size:28px;font-weight:650;margin-top:10px}.detail{font-size:12px;color:#9cabb8;margin-top:8px}
.checks{background:#1a2631;border:1px solid #2c3b47;border-radius:14px;overflow:hidden}h2{font-size:20px;margin:0;padding:22px}.row{display:flex;justify-content:space-between;align-items:center;gap:16px;padding:16px 22px;border-top:1px solid #2c3b47}.target{font-size:13px;color:#adbecb;margin-top:5px;overflow-wrap:anywhere}.result{font-size:13px;font-weight:600;white-space:nowrap}.pass{color:#91efc9}.fail{color:#ffcc95}.footer{font-size:13px;margin-top:20px}#message{color:#ffcc95}
@media(max-width:720px){.grid{grid-template-columns:repeat(2,1fr)}.top{align-items:flex-start;flex-direction:column}h1{font-size:30px}}
@media(max-width:400px){.grid{grid-template-columns:1fr}.row{align-items:flex-start;flex-direction:column}}
</style>
</head>
<body><main>
<div class="top"><div><div class="eyebrow">FischerLab / Infrastructure operations</div><h1>Lab health overview</h1><p>Observed host metrics and endpoint reachability from OPS01.</p></div><div id="status" class="badge" role="status">Loading snapshot</div></div>
<div id="message" role="alert"></div>
<div class="grid">
<div class="card"><div class="label">Collector host</div><div class="value" id="host">—</div><div class="detail" id="uptime">Waiting for data</div></div>
<div class="card"><div class="label">Memory used</div><div class="value" id="memory">—</div><div class="detail" id="memory-detail">Waiting for data</div></div>
<div class="card"><div class="label">Root disk used</div><div class="value" id="disk">—</div><div class="detail" id="disk-detail">Waiting for data</div></div>
<div class="card"><div class="label">Load average · 1 minute</div><div class="value" id="load">—</div><div class="detail" id="freshness">Waiting for data</div></div>
</div>
<section class="checks"><h2>Endpoint checks</h2><div id="checks"></div></section>
<p class="footer" id="updated">No snapshot loaded.</p>
<p class="footer">Collection approximately every minute · View refreshes every 15 seconds · A snapshot older than 3 minutes is marked stale.<br>DNS resolution and TCP reachability only; these checks do not verify authenticated service health. Personal lab with simulated company data.</p>
</main>
<script>
const element=id=>document.getElementById(id);
const gib=bytes=>(bytes/1073741824).toFixed(1)+' GiB';
let latest=null;
function freshness(){
 if(!latest)return;
 const age=Math.max(0,Math.round((Date.now()-Date.parse(latest.collected_at))/1000));
 const stale=!Number.isFinite(age)||age>180;
 element('freshness').textContent=Number.isFinite(age)?'Snapshot age: '+age+' seconds':'Invalid timestamp';
 element('status').textContent=stale?'Snapshot stale':latest.status==='healthy'?'Checks passing':'Needs attention';
 element('status').className='badge '+(!stale&&latest.status==='healthy'?'good':'bad');
}
async function refresh(){
 try{
  const response=await fetch('/api/health',{cache:'no-store'});
  if(!response.ok)throw new Error('HTTP '+response.status);
  const data=await response.json();
  if(!data.memory||!data.root_disk||!Array.isArray(data.checks))throw new Error('Invalid snapshot');
  latest=data;
  element('message').textContent='';
  element('host').textContent=data.hostname;
  element('uptime').textContent='Uptime: '+Math.floor(data.uptime_seconds/3600)+'h '+Math.floor(data.uptime_seconds%3600/60)+'m';
  element('memory').textContent=data.memory.used_percent+'%';
  element('memory-detail').textContent=gib(data.memory.available_bytes)+' available';
  element('disk').textContent=data.root_disk.used_percent+'%';
  element('disk-detail').textContent=gib(data.root_disk.free_bytes)+' free';
  element('load').textContent=Number(data.load_average[0]).toFixed(2);
  element('updated').textContent='Collected: '+new Date(data.collected_at).toISOString()+' · UTC';
  element('checks').replaceChildren();
  for(const check of data.checks){
   const row=document.createElement('div');row.className='row';
   const description=document.createElement('div');
   const name=document.createElement('div');name.textContent=check.name;
   const target=document.createElement('div');target.className='target';
   target.textContent=check.host+(check.port?':'+check.port:'')+(check.error?' · '+check.error:'');
   description.append(name,target);
   const result=document.createElement('div');result.className='result '+(check.ok?'pass':'fail');result.textContent=check.ok?'PASS':'FAIL';
   row.append(description,result);element('checks').append(row);
  }
  freshness();
 }catch(error){
  element('message').textContent='Unable to refresh snapshot. Check the SSH tunnel and dashboard service. Previously displayed data may be outdated.';
  element('status').textContent='View disconnected';element('status').className='badge bad';
 }
}
refresh();setInterval(refresh,15000);
</script></body></html>
HTML
sudo tee /etc/systemd/system/fischerlab-dashboard.service >/dev/null <<'SERVICE'
[Unit]
Description=FischerLab read-only operations dashboard
After=network.target

[Service]
User=kf
Group=kf
WorkingDirectory=/home/kf/fischerlab-health
ExecStart=/usr/bin/python3 /home/kf/fischerlab-health/health-dashboard.py
Restart=on-failure
RestartSec=5
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
ProtectHome=read-only

[Install]
WantedBy=multi-user.target
SERVICE
sudo systemd-analyze verify /etc/systemd/system/fischerlab-dashboard.service
sudo systemctl daemon-reload
sudo systemctl enable --now fischerlab-dashboard.service
systemctl status fischerlab-dashboard --no-pager
curl -fsS --retry 10 --retry-connrefused --retry-delay 1 --max-time 5 http://127.0.0.1:8080/api/health | jq '{collected_at, hostname, status}'
