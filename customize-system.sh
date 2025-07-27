#!/bin/bash
set -e

echo "🔧 Starting system customization..."

# Update system
echo "📦 Updating package lists..."
apt-get update

echo "⬆️ Upgrading system packages..."
apt-get upgrade -y

# Install essential development tools
echo "🛠️ Installing development tools..."
apt-get install -y \
  build-essential \
  software-properties-common \
  apt-transport-https \
  ca-certificates \
  gnupg \
  lsb-release \
  curl \
  wget \
  git \
  vim \
  nano \
  htop \
  tree \
  unzip \
  zip

# Install Python 3.12 and related tools
echo "🐍 Installing Python 3.12..."
apt-get install -y \
  python3.12 \
  python3.12-venv \
  python3.12-dev \
  python3-pip \
  pipx \
  python3-setuptools \
  python3-wheel

# Create python3 symlink
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1
update-alternatives --install /usr/bin/python python /usr/bin/python3.12 1

# Verify NVIDIA drivers (already included in Pop!_OS NVIDIA ISO)
echo "🔍 Verificando drivers NVIDIA preinstalados..."
if command -v nvidia-smi &> /dev/null; then
    echo "✅ Drivers NVIDIA detectados:"
    nvidia-smi --query-gpu=name,driver_version --format=csv,noheader
else
    echo "⚠️ Advertencia: nvidia-smi no encontrado"
fi

# Setup Docker repository
echo "🐳 Setting up Docker repository..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu jammy stable" > /etc/apt/sources.list.d/docker.list
apt-get update

# Install Docker
echo "🐳 Installing Docker..."
apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-compose-plugin

# Configure Docker to start on boot
systemctl enable docker

echo "✅ System customization completed!"
