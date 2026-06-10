#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_SRC="$ROOT/bin"
BIN_DST="$HOME/.local/bin"

install -d "$BIN_DST"

for src in "$BIN_SRC"/*; do
  name="$(basename "$src")"
  dst="$BIN_DST/$name"

  if [ -L "$src" ]; then
    target="$(readlink -f "$src")"
    ln -sfn "$target" "$dst"
  else
    install -m 755 "$src" "$dst"
  fi
done

cp "$ROOT/.bash_aliases" "$HOME/.bash_aliases"
echo "Synced bin and .bash_aliases"
echo "Run reloadsh"
