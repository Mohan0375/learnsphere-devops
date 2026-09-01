#!/usr/bin/env bash
set -euo pipefail

URL="${1:-http://127.0.0.1:5000/health}"
RETRIES="${RETRIES:-12}"
SLEEP_SECONDS="${SLEEP_SECONDS:-5}"

echo "Checking deployment health: ${URL}"

for attempt in $(seq 1 "$RETRIES"); do
  if curl --fail --silent --show-error --max-time 5 "$URL" | tee /tmp/learnsphere-health.json; then
    echo
    echo "Health check passed on attempt ${attempt}."
    exit 0
  fi

  echo "Health check attempt ${attempt}/${RETRIES} failed; retrying in ${SLEEP_SECONDS}s..."
  sleep "$SLEEP_SECONDS"
done

echo "Health check failed after ${RETRIES} attempts."
exit 1
