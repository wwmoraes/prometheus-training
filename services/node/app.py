#!/usr/bin/env python3

import http.server
from prometheus_client import generate_latest, Counter, Histogram

REQUESTS = Counter('app_requests', 'Total requests served by app')
REQUEST_TIME = Histogram('app_http_request_duration_seconds', 'Histogram of latencies for HTTP requests.')

class Handler(http.server.BaseHTTPRequestHandler):
  @REQUEST_TIME.time()
  def do_GET(self):
    if self.path == "/metrics":
      self.send_response(200)
      self.send_header('Content-Type', 'text/plain; charset=utf-8')
      self.end_headers()
      self.wfile.write(generate_latest())
    else:
      REQUESTS.inc()
      self.send_response(200)
      self.end_headers()
      self.wfile.write(b"OK")

if __name__ == "__main__":
  server = http.server.HTTPServer(('0.0.0.0', 8080), Handler)
  server.serve_forever()
