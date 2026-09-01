#!/usr/bin/env bash
set -euo pipefail

# Usage: ./scripts/deploy.sh IMAGE_NAME IMAGE_TAG
IMAGE_NAME="${1:?Image name is required}"
IMAGE_TAG="${2:?Image tag is required}"
APP_DIR="${APP_DIR:-/opt/learnsphere}"
IMAGE="${IMAGE_NAME}:${IMAGE_TAG}"

cd "$APP_DIR"
mkdir -p .rollback

CURRENT_FILE=".current_image"
PREVIOUS_IMAGE="$(cat "$CURRENT_FILE" 2>/dev/null || true)"

if [[ -n "$PREVIOUS_IMAGE" ]]; then
  echo "$PREVIOUS_IMAGE" > .rollback/previous_image
fi

echo "Pulling ${IMAGE}"
docker pull "$IMAGE"

echo "Starting ${IMAGE}"
export LEARN_SPHERE_IMAGE="$IMAGE"
docker compose up -d --force-recreate

echo "Current image: ${IMAGE}"
echo "$IMAGE" > "$CURRENT_FILE"
