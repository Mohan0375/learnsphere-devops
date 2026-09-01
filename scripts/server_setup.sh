#!/usr/bin/env bash
set -euo pipefail

# Run once on a fresh Ubuntu EC2 host.
sudo apt-get update
sudo apt-get install -y docker.io docker-compose-plugin curl
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

sudo mkdir -p /opt/learnsphere/scripts
sudo chown -R "$USER:$USER" /opt/learnsphere

echo "Server prepared. Log out/in once so the docker group membership is refreshed."
echo "Copy .env.example to /opt/learnsphere/.env and set real RDS values securely."
