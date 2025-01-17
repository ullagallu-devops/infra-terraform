#!/bin/bash

set -e
set -o pipefail
set -u

# Define Colors for Logging
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

# Ensure Root Privileges
if [ "$EUID" -ne 0 ]; then
    error "Please run as root (use ."
fi

# --- Update System Packages ---
log "Updating system packages..."
dnf update -y

# --- Install Required Packages ---
PACKAGES=("git" "tmux" "tree")

for package in "${PACKAGES[@]}"; do
    if ! rpm -q "$package" &>/dev/null; then
        log "Installing $package..."
        dnf install -y "$package"
    else
        log "$package is already installed."
    fi
done

# --- kubectl ---
if ! command -v kubectl &> /dev/null; then
    log "Installing kubectl..."
    curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.2/2024-11-15/bin/linux/amd64/kubectl
    chmod +x kubectl
    mv kubectl /usr/local/bin/
fi

if ! command -v k9s &> /dev/null; then
    log "Installing k9s..."
    
    # Install k9s using Webi
    curl -sS https://webinstall.dev/k9s | bash
    
    # Create symlink in /usr/local/bin with proper permissions
    if [ -w /usr/local/bin ]; then
        ln -sf "$HOME/.local/bin/k9s" /usr/local/bin/k9s
    else
        log "Insufficient permissions to write to /usr/local/bin. Using sudo..."
        sudo ln -sf "$HOME/.local/bin/k9s" /usr/local/bin/k9s
    fi
    
    log "k9s installed successfully."
else
    log "k9s is already installed."
fi

if ! command -v kubectx &> /dev/null; then
    log "Installing kubectx and kubens..."
    git clone https://github.com/ahmetb/kubectx /opt/kubectx
    ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
    ln -s /opt/kubectx/kubens /usr/local/bin/kubens
else
    log "kubectx and kubens are already installed."
fi