#!/usr/bin/env bash

set -Eeuo pipefail

REPO_URL="https://raw.githubusercontent.com/Go-oN-JP/wol/main"
INSTALL_PATH="/usr/local/bin/wol"
CONFIG_DIR="/etc/wol"
CONFIG_FILE="${CONFIG_DIR}/hosts"

if [[ $EUID -ne 0 ]]; then
    echo "Error: Run this installer with sudo." >&2
    exit 1
fi

if [[ ! -r /etc/os-release ]]; then
    echo "Error: Cannot identify the operating system." >&2
    exit 1
fi

. /etc/os-release

case "${ID:-}" in
    debian|ubuntu)
        ;;
    *)
        echo "Error: This installer supports Debian and Ubuntu only." >&2
        exit 1
        ;;
esac

if ! command -v apt-get >/dev/null 2>&1; then
    echo "Error: apt-get is not available." >&2
    exit 1
fi

echo "Installing dependencies..."
apt-get update
apt-get install -y curl wakeonlan

echo "Downloading wol..."
TMP_FILE="$(mktemp)"
trap 'rm -f "$TMP_FILE"' EXIT

if ! curl -fsSL "${REPO_URL}/wol" -o "$TMP_FILE"; then
    echo "Error: Failed to download wol." >&2
    exit 1
fi

if [[ ! -s "$TMP_FILE" ]]; then
    echo "Error: Downloaded wol is empty." >&2
    exit 1
fi

if ! head -n 1 "$TMP_FILE" | grep -q '^#!/usr/bin/env bash$'; then
    echo "Error: Downloaded file does not appear to be a wol script." >&2
    exit 1
fi

install -D -m 755 "$TMP_FILE" "$INSTALL_PATH"

mkdir -p "$CONFIG_DIR"
chmod 755 "$CONFIG_DIR"

if [[ ! -e "$CONFIG_FILE" ]]; then
    cat > "$CONFIG_FILE" <<'EOF'
# IP address       MAC address          Hostname
# Add one host per line in the format:
# IP_ADDRESS MAC_ADDRESS [HOSTNAME]
#
# Example:
# 192.168.1.10  aa:bb:cc:dd:ee:ff  pc01
EOF
    chmod 644 "$CONFIG_FILE"
    echo "Created configuration file: $CONFIG_FILE"
else
    echo "Existing configuration preserved: $CONFIG_FILE"
fi

echo
echo "Installation completed."
echo "Executable: $INSTALL_PATH"
echo "Configuration: $CONFIG_FILE"
echo
echo "Edit the configuration file and run 'wol' to list hosts."
