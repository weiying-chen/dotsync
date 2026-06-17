#!/usr/bin/env bash
set -euo pipefail

SCRIPT_PATH="$(readlink -f "${BASH_SOURCE[0]}")"
ROOT="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
BIN_SRC="$ROOT/bin"
BIN_DST="$HOME/.local/bin"
TMUX_SRC="$ROOT/tmux/tmux.conf"
TMUX_DST="$HOME/.tmux.conf"
changes=()

install -d "$BIN_DST"

sync_file() {
  local src="$1"
  local dst="$2"
  local mode="$3"
  local label="$4"

  install -d "$(dirname "$dst")"
  if [ ! -e "$dst" ] || ! cmp -s "$src" "$dst"; then
    install -m "$mode" "$src" "$dst"
    changes+=("[copy] $label")
  fi
}

for src in "$BIN_SRC"/*; do
  name="$(basename "$src")"
  dst="$BIN_DST/$name"

  if [ -L "$src" ]; then
    target="$(readlink -f "$src")"
    if [ ! -L "$dst" ] || [ "$(readlink -f "$dst")" != "$target" ]; then
      ln -sfn "$target" "$dst"
      changes+=("[symlink] bin/$name -> $target")
    fi
  else
    if [ ! -e "$dst" ] || ! cmp -s "$src" "$dst"; then
      install -m 755 "$src" "$dst"
      changes+=("[install] bin/$name")
    fi
  fi
done

sync_file "$ROOT/.bash_aliases" "$HOME/.bash_aliases" 644 ".bash_aliases"
sync_file "$TMUX_SRC" "$TMUX_DST" 644 "tmux/tmux.conf -> ~/.tmux.conf"

if [ "${#changes[@]}" -eq 0 ]; then
  echo "No file changes"
else
  printf 'Updated:\n'
  printf '%s\n' "${changes[@]}"
fi
echo "Run reloadsh"
