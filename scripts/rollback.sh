#!/usr/bin/env bash
set -euo pipefail

APP_DIR="${APP_DIR:-/opt/learnsphere}"
cd "$APP_DIR"

if [[ ! -f .rollback/previous_image ]]; then
  echo "No previous image is recorded; rollback cannot continue."
  exit 1
fi

PREVIOUS_IMAGE="$(cat .rollback/previous_image)"
echo "Rolling back to ${PREVIOUS_IMAGE}"

docker pull "$PREVIOUS_IMAGE"
export LEARN_SPHERE_IMAGE="$PREVIOUS_IMAGE"
docker compose up -d --force-recreate

echo "$PREVIOUS_IMAGE" > .current_image
echo "Rollback completed."
