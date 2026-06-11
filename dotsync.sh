#!/usr/bin/env bash
set -euo pipefail

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
ROOT="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
BIN_SRC="$ROOT/bin"
BIN_DST="$HOME/.local/bin"
changes=()

install -d "$BIN_DST"

for src in "$BIN_SRC"/*; do
  name="$(basename "$src")"
  dst="$BIN_DST/$name"

  if [ -L "$src" ]; then
    target="$(readlink -f "$src")"
    if [ ! -L "$dst" ] || [ "$(readlink -f "$dst")" != "$target" ]; then
      ln -sfn "$target" "$dst"
      changes+=("bin/$name -> $target")
    fi
  else
    if [ ! -e "$dst" ] || ! cmp -s "$src" "$dst"; then
      install -m 755 "$src" "$dst"
      changes+=("bin/$name")
    fi
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
