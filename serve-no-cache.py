#!/usr/bin/env python3
"""
serve-no-cache.py - local development web server for MT Travel.

This exists specifically to solve one problem: when you replace an image
(or any file) on disk while testing locally and keep the exact same
filename, browsers very commonly keep showing the OLD cached version on
a normal refresh - this happens on nearly every website during
development, not just this one. The standard fix is to tell the server
to never let the browser cache anything, so every refresh always shows
exactly what's on disk right now.

start.sh and start.bat both run this instead of the plain
`python -m http.server` for exactly that reason. It behaves identically
otherwise - same directory, same port - it just adds three response
headers that disable caching entirely.
"""
import http.server
import socketserver
import sys

PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 8000


class NoCacheHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0")
        self.send_header("Pragma", "no-cache")
        self.send_header("Expires", "0")
        super().end_headers()

    def log_message(self, format, *args):
        # Keep the console output the same as the plain http.server module
        # so anyone watching the window sees the familiar request log.
        sys.stderr.write("%s - - [%s] %s\n" % (self.address_string(), self.log_date_time_string(), format % args))


class ReusableTCPServer(socketserver.TCPServer):
    allow_reuse_address = True


if __name__ == "__main__":
    with ReusableTCPServer(("", PORT), NoCacheHandler) as httpd:
        print(f"Serving on http://localhost:{PORT} (caching disabled for local development)")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            pass
