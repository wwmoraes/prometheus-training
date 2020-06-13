#!/bin/sh

set -m

./node_exporter --collector.systemd &
exec ./prometheus --web.enable-lifecycle
