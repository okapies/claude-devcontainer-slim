#!/bin/bash
set -euo pipefail

BASE_DIR=$(cd "$(dirname "$0")" || exit; pwd)

# Install Claude Code using native installer
su ${_REMOTE_USER} -c "curl -fsSL https://claude.ai/install.sh | bash"

# Copy and set up firewall script
cp "${BASE_DIR}/init-firewall.sh" /usr/local/bin/init-firewall.sh
chmod +x /usr/local/bin/init-firewall.sh
echo "${_REMOTE_USER} ALL=(root) NOPASSWD: /usr/local/bin/init-firewall.sh" > /etc/sudoers.d/${_REMOTE_USER}-firewall
chmod 0440 /etc/sudoers.d/${_REMOTE_USER}-firewall
