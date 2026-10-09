#!/usr/bin/env python3
"""Collect observed host metrics and lab endpoint reachability using stdlib only."""
import argparse
import json
import os
from pathlib import Path
import shutil
import socket
import tempfile
from datetime import datetime, timezone


def tcp_check(label, host, port):
    try:
        with socket.create_connection((host, port), timeout=3):
            pass
        return {"name": label, "host": host, "port": port, "ok": True}
    except OSError as error:
        return {"name": label, "host": host, "port": port,
                "ok": False, "error": str(error)}


def dns_check(label, host, expected=None):
    try:
        addresses = sorted({item[4][0] for item in socket.getaddrinfo(
            host, None, family=socket.AF_INET)})
        ok = bool(addresses) and (expected is None or expected in addresses)
        return {"name": label, "host": host, "ok": ok,
                "addresses": addresses, "expected": expected}
    except OSError as error:
        return {"name": label, "host": host, "ok": False, "error": str(error)}


def collect():
    memory = {}
    for line in Path('/proc/meminfo').read_text().splitlines():
        key, value = line.split(':', 1)
        memory[key] = int(value.split()[0]) * 1024
    disk = shutil.disk_usage('/')
    memory_percent = round(100 * (1 - memory['MemAvailable'] / memory['MemTotal']), 1)
    disk_percent = round(100 * disk.used / disk.total, 1)
    checks = [
        dns_check('DC01 DNS record', 'DC01.corp.fischerlab.test', '10.10.10.10'),
        dns_check('External DNS resolution', 'example.com'),
        tcp_check('DC01 DNS TCP', '10.10.10.10', 53),
        tcp_check('DC01 LDAP TCP', '10.10.10.10', 389),
        tcp_check('FS01 SMB TCP', '10.10.10.20', 445),
        tcp_check('OPS01 local SSH TCP', '127.0.0.1', 22),
    ]
    return {
        'collected_at': datetime.now(timezone.utc).isoformat(),
        'hostname': socket.gethostname(),
        'status': 'healthy' if all(check['ok'] for check in checks)
                  and disk_percent < 85 and memory_percent < 90 else 'attention',
        'uptime_seconds': int(float(Path('/proc/uptime').read_text().split()[0])),
        'load_average': list(os.getloadavg()),
        'memory': {'total_bytes': memory['MemTotal'],
                   'available_bytes': memory['MemAvailable'], 'used_percent': memory_percent},
        'root_disk': {'total_bytes': disk.total, 'free_bytes': disk.free,
                      'used_percent': disk_percent},
        'checks': checks,
        'scope': 'DNS resolution and TCP reachability only; no authenticated service health checks',
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=Path('health.json'))
    args = parser.parse_args()
    snapshot = collect()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    temporary = None
    try:
        with tempfile.NamedTemporaryFile(mode='w', dir=args.output.parent,
                                         prefix='.health-', delete=False) as stream:
            temporary = Path(stream.name)
            json.dump(snapshot, stream, indent=2)
            stream.write('\n')
        os.replace(temporary, args.output)
    finally:
        if temporary is not None:
            temporary.unlink(missing_ok=True)
    print(f"{snapshot['status']}: wrote {args.output}")


if __name__ == '__main__':
    main()
