#!/usr/bin/env bash
# Build both lily58 halves and copy the firmware into install/.
#
# One-time setup this script assumes is already done:
#   uv venv .venv && uv pip install --python .venv west
#   source .venv/bin/activate && west init -l config && west update
#   uv pip install --python .venv -r zephyr/scripts/requirements-base.txt
#   Zephyr SDK (arm-zephyr-eabi toolchain) installed and registered
#     (west zephyr-export, and the SDK's setup.sh -t arm-zephyr-eabi -c)
#
# Usage: ./build.sh [--pristine]
#   --pristine  force a clean CMake reconfigure (use after switching
#               board/shield, or if a build dir gets into a weird state)
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -d .venv ]; then
  echo "error: .venv not found. Run the one-time toolchain setup first (see comment at the top of this script)." >&2
  exit 1
fi

# shellcheck disable=SC1091
source .venv/bin/activate
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr

pristine_flag=""
if [ "${1:-}" = "--pristine" ]; then
  pristine_flag="-p always"
fi

zmk_config="$PWD/config"
install_dir="$PWD/install"
mkdir -p "$install_dir"

for half in left right; do
  shield="lily58_${half} nice_view_adapter nice_view_battery"
  echo "==> building $half ($shield)"
  west build -d "build/$half" -s zmk/app -b nice_nano_v2 $pristine_flag -- \
    -DSHIELD="$shield" -DZMK_CONFIG="$zmk_config"

  out="$install_dir/lily58_${half}.uf2"
  cp "build/$half/zephyr/zmk.uf2" "$out"
  echo "==> wrote $out"
done

echo
echo "Done. Flash by double-tapping reset on each half and dragging the matching .uf2 file onto the drive that appears."
