#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_SRC="$ROOT/bin"
BIN_DST="$HOME/.local/bin"
changes=()

install -d "$BIN_DST"

for src in "$BIN_SRC"/*; do
  name="$(basename "$src")"
  dst="$BIN_DST/$name"

  if [ ! -e "$dst" ] || ! cmp -s "$src" "$dst"; then
    install -m 755 "$src" "$dst"
    changes+=("bin/$name")
  fi
done

if [ ! -e "$HOME/.bash_aliases" ] || ! cmp -s "$ROOT/.bash_aliases" "$HOME/.bash_aliases"; then
  cp "$ROOT/.bash_aliases" "$HOME/.bash_aliases"
  changes+=(".bash_aliases")
fi

if [ "${#changes[@]}" -eq 0 ]; then
  echo "No file changes"
else
  echo "Updated: ${changes[*]}"
fi
echo "Run reloadsh"
