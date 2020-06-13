#!/bin/sh

set -m

./node_exporter --collector.systemd &
exec ./bin/grafana-server web
