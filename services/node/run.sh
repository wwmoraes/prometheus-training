#!/bin/sh

set -m

./node_exporter --collector.systemd &
exec ./app.py
