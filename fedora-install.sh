#!/bin/bash

source "$(dirname "$0")/vars.sh"
source "$(dirname "$0")/functions.sh"

# =====================================================
# Dev Environment & Proprietary Fixes Setup Script for Fedora 41
# =====================================================
# This script is designed to set up a development environment on Fedora 41
# for Go backend development and Flutter frontend development.
#
# Additionally, it fixes issues related to Fedora 41's strict proprietary
# software policies, which cause the system to fall back to LLVMpipe
# (software rendering) instead of using AMDGPU for Radeon GPUs.
#
# This script will:
#  - Remove "nomodeset" from GRUB to enable AMDGPU.
#  - Install missing AMDGPU drivers, Mesa, and Vulkan.
#  - Fix hardware acceleration for AMD Radeon GPUs.
#
# =====================================================
# Post-Installation Steps
# =====================================================
# 1 - Make Caps Lock act as Control to facilitate Neovim keybindings:
#
# 2 - Create and configure SSH keys for GitLab and GitHub:
#    - Generate a new SSH key: ssh-keygen -t ed25519 -C "your_email@example.com"
#    - Start the SSH agent: eval "$(ssh-agent -s)"
#    - Add the SSH key: ssh-add ~/.ssh/id_ed25519
#    - Copy the SSH key to clipboard: cat ~/.ssh/id_ed25519.pub | xclip -sel clip
#    - Add the key to GitHub and GitLab via their web interfaces.
#
# =====================================================
# Manual Verification Before Running the Script
# =====================================================
# 1 - Verify the latest version of Android Studio at:
#    https://developer.android.com/studio/archive
# =====================================================

# Exit immediately if a command fails.
set -e

# ==================== LOGGING ====================
>"$LOG_FILE"
exec > >(tee -a "$LOG_FILE") 2>&1

# ==================== EXECUTION ====================
echo "========== 🚀 Starting Installation: $(date) =========="
check_internet
sudo -v
while sudo -v; do sleep 60; done 2>/dev/null &
echo "🔄 Updating Fedora system..."
sudo dnf update -y
install_dnf_packages
fix_amdgpu_on_fedora
setup_dotfiles
install_librewolf
install_docker
install_dropbox
install_pipx_commitizen
setup_flatpak
install_rust
install_font
install_flutter
install_android_studio
echo "🦫 Installing Go-Swagger..."
go install "$GO_SWAGGER_URL" || echo "$FAILURE Go-Swagger installation skipped."
echo "$SUCCESS Go-Swagger installation completed."
echo "🦋 Running Flutter doctor..."
flutter doctor
echo "========== 🎉 Installation Completed: $(date) =========="
echo "$SUCCESS Please restart your system for changes to take effect."
