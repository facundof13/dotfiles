#!/bin/bash
# Sync Advantage 360 keyboard config between dotfiles and the keyboard's USB drive.
#
# Usage:
#   ./sync.sh push   - Copy dotfiles -> keyboard (apply your changes)
#   ./sync.sh pull   - Copy keyboard -> dotfiles (save current state)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
KEYBOARD="/Volumes/ADV360"

if [ ! -d "$KEYBOARD" ]; then
  echo "Error: ADV360 drive not mounted at $KEYBOARD"
  echo "Plug in the keyboard via USB and press SmartSet + F1 to mount."
  exit 1
fi

case "${1:-}" in
  push)
    echo "Pushing dotfiles -> keyboard..."
    cp "$SCRIPT_DIR/layouts/layout1.txt" "$KEYBOARD/layouts/layout1.txt"
    cp "$SCRIPT_DIR/layouts/layout2.txt" "$KEYBOARD/layouts/layout2.txt"
    cp "$SCRIPT_DIR/lighting/led1.txt"   "$KEYBOARD/lighting/led1.txt"
    cp "$SCRIPT_DIR/lighting/led2.txt"   "$KEYBOARD/lighting/led2.txt"
    echo "Done. Press SmartSet + F1 on the keyboard to reload."
    ;;
  pull)
    echo "Pulling keyboard -> dotfiles..."
    cp "$KEYBOARD/layouts/layout1.txt" "$SCRIPT_DIR/layouts/layout1.txt"
    cp "$KEYBOARD/layouts/layout2.txt" "$SCRIPT_DIR/layouts/layout2.txt"
    cp "$KEYBOARD/lighting/led1.txt"   "$SCRIPT_DIR/lighting/led1.txt"
    cp "$KEYBOARD/lighting/led2.txt"   "$SCRIPT_DIR/lighting/led2.txt"
    cp "$KEYBOARD/settings/settings.txt" "$SCRIPT_DIR/settings/settings.txt"
    echo "Done. Don't forget to commit the changes."
    ;;
  *)
    echo "Usage: $0 {push|pull}"
    exit 1
    ;;
esac
