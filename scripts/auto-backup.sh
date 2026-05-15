#!/bin/bash
# Auto-commits and pushes memory/config changes to the private repo.
# Throttled: only runs if last backup was >6 hours ago.

REPO_DIR="/Users/sahandilshan/IAM/thunder-developments/thunder-discussions"
TIMESTAMP_FILE="$REPO_DIR/.last-backup"
THROTTLE_SECONDS=21600  # 6 hours

if [ -f "$TIMESTAMP_FILE" ]; then
  LAST_BACKUP=$(cat "$TIMESTAMP_FILE")
  NOW=$(date +%s)
  ELAPSED=$((NOW - LAST_BACKUP))
  if [ "$ELAPSED" -lt "$THROTTLE_SECONDS" ]; then
    exit 0
  fi
fi

cd "$REPO_DIR" || exit 0

if git diff --quiet HEAD -- memory/ CLAUDE.md .claude/ scripts/ 2>/dev/null; then
  date +%s > "$TIMESTAMP_FILE"
  exit 0
fi

git add memory/ CLAUDE.md .claude/settings.json scripts/ setup.sh .gitignore 2>/dev/null
git commit -m "Auto-backup: memory and config $(date +%Y-%m-%d)" 2>/dev/null || exit 0
git push origin main 2>/dev/null || true

date +%s > "$TIMESTAMP_FILE"
