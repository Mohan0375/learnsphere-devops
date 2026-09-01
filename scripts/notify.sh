#!/usr/bin/env bash
set -euo pipefail

# Optional Slack webhook notification.
# Set SLACK_WEBHOOK_URL as a deployment secret/environment variable.
MESSAGE="${1:-LearnSphere pipeline event}"

if [[ -z "${SLACK_WEBHOOK_URL:-}" ]]; then
  echo "SLACK_WEBHOOK_URL is not configured; notification skipped."
  exit 0
fi

curl -fsS -X POST \
  -H 'Content-type: application/json' \
  --data "$(python -c 'import json,sys; print(json.dumps({"text":sys.argv[1]}))' "$MESSAGE")" \
  "$SLACK_WEBHOOK_URL"
