#!/bin/bash
# Auto-commits and pushes memory/config changes to the private repo.
# Throttled: only runs if last backup was >1 hour ago.

REPO_DIR="/Users/sahandilshan/IAM/thunder-developments/thunder-discussions"
TIMESTAMP_FILE="$REPO_DIR/.last-backup"
THROTTLE_SECONDS=3600  # 1 hour

if [ -f "$TIMESTAMP_FILE" ]; then
  LAST_BACKUP=$(cat "$TIMESTAMP_FILE")
  NOW=$(date +%s)
  ELAPSED=$((NOW - LAST_BACKUP))
  if [ "$ELAPSED" -lt "$THROTTLE_SECONDS" ]; then
    exit 0
  fi
fi

cd "$REPO_DIR" || exit 0

# Check for ANY changes: modified tracked files OR new untracked files
HAS_TRACKED_CHANGES=false
HAS_UNTRACKED_FILES=false

git diff --quiet HEAD -- memory/ CLAUDE.md .claude/ scripts/ setup.sh .gitignore 2>/dev/null || HAS_TRACKED_CHANGES=true

if [ -n "$(git ls-files --others --exclude-standard memory/ 2>/dev/null)" ]; then
  HAS_UNTRACKED_FILES=true
fi

if [ "$HAS_TRACKED_CHANGES" = false ] && [ "$HAS_UNTRACKED_FILES" = false ]; then
  date +%s > "$TIMESTAMP_FILE"
  exit 0
fi

git add memory/ CLAUDE.md .claude/settings.json scripts/ setup.sh .gitignore 2>/dev/null
git commit -m "Auto-backup: memory and config $(date +%Y-%m-%d-%H%M)" 2>/dev/null || exit 0
git push origin main 2>/dev/null || true

date +%s > "$TIMESTAMP_FILE"
