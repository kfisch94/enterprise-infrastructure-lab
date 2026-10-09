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
