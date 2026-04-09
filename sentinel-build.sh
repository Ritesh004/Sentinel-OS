#!/bin/sh
set -eu

# Sentinel OS build wrapper.
# Keeps upstream directory names intact, while providing a Sentinel-named entrypoint.

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
exec "$ROOT_DIR/sentinel-live-main/sentinel-live-main/build.sh" "$@"

