#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
install -d "$HOME/.local/bin"
rsync -av --delete "$ROOT/bin/" "$HOME/.local/bin/"
cp "$ROOT/.bash_aliases" "$HOME/.bash_aliases"
echo "Synced bin and .bash_aliases"
echo "Run reloadsh"
