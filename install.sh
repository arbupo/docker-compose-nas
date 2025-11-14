#!/bin/bash

set -e

# Ensure required tools are present
sudo apt-get update -y
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common

# Add Docker’s official GPG key (for arm64)
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker's repository for ARM (arm64)
echo \
  "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index again
sudo apt-get update -y

# Install Docker packages (ARM-compatible)
sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin \
    fail2ban

# Ensure docker group exists
sudo groupadd -f docker

# Add the current user to the docker group
sudo usermod -aG docker $USER

# Completion message
echo "✅ Docker installation completed on ARM (OCI)."
echo "ℹ️  You may need to log out and log back in for group changes to take effect."