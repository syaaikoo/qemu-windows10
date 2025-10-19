#!/bin/bash
set -euo pipefail

df -h

sudo mkdir -p /tmp/docker-data

sudo tee /etc/docker/daemon.json > /dev/null <<'JSON'
{
  "data-root": "/tmp/docker-data"
}
JSON
