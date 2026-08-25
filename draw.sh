#!/usr/bin/env bash
# Regenerate keymap-drawer/lily58.svg from config/lily58.keymap.
# Runs keymap-drawer via uv (no persistent install needed). If zmk-helpers/
# isn't already checked out locally (e.g. from the west workspace setup in
# README.md), a throwaway shallow clone is made just to read its headers.
set -euo pipefail
cd "$(dirname "$0")"

if ! command -v uvx >/dev/null; then
  echo "error: uv/uvx not found. Install uv (https://docs.astral.sh/uv/) first." >&2
  exit 1
fi

cleanup=""
trap '[ -n "$cleanup" ] && rm -rf "$cleanup"' EXIT

if [ -d zmk-helpers ]; then
  include_dir=zmk-helpers/include
else
  echo "==> zmk-helpers/ not found locally, cloning a throwaway copy"
  cleanup=.zmk-helpers-tmp
  git clone --quiet --depth 1 --branch v0.3 https://github.com/urob/zmk-helpers "$cleanup"
  include_dir="$cleanup/include"
fi

config_file="$(mktemp)"
cat > "$config_file" <<EOF
parse_config:
  zmk_additional_includes:
    - $include_dir
EOF

mkdir -p keymap-drawer
tmp_yaml="$(mktemp)"
uvx --from keymap-drawer keymap -c "$config_file" parse -z config/lily58.keymap -c 6 -o "$tmp_yaml"
uvx --from keymap-drawer keymap draw "$tmp_yaml" -o keymap-drawer/lily58.svg
rm -f "$config_file" "$tmp_yaml"

echo "==> wrote keymap-drawer/lily58.svg"
