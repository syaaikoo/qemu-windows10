#!/bin/bash
mkdir -p ~/windows-rdp
cd ~/windows-rdp

cat > .env <<'ENV'
WINDOWS_USERNAME=AiraaCheisyaa
WINDOWS_PASSWORD=airaacheisyaa

cat > windows11.yml <<'YML'
services:
  windows:
    image: dockurr/windows
    container_name: windows
    environment:
      VERSION: "11"
      USERNAME: \${WINDOWS_USERNAME}
      PASSWORD: \${WINDOWS_PASSWORD}
      RAM_SIZE: "4G"
      CPU_CORES: "4"
    cap_add:
      - NET_ADMIN
    ports:
      - "8006:8006"
      - "3389:3389/tcp"
    volumes:
      - /tmp/docker-data:/mnt/disco1
      - windows-data:/mnt/windows-data
    devices:
      - "/dev/kvm:/dev/kvm"
      - "/dev/net/tun:/dev/net/tun"
    stop_grace_period: 2m

volumes:
  windows-data:
YML

docker volume create windows-data || true

sudo docker compose -f windows11.yml up -d

sudo docker ps --filter name=windows
sudo docker logs -f windows
