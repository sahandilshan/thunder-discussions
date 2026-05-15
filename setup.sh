#!/bin/bash
# Restores the thunder-discussions environment on a fresh machine.
# Run this after cloning: git clone git@github.com:sahandilshan/thunder-discussions.git
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
MEMORY_TARGET="$HOME/.claude/projects/-Users-sahandilshan-IAM-thunder-developments-thunder-discussions/memory"

echo "=== Thunder Discussions Setup ==="

# 1. Set up memory symlink
echo "[1/3] Setting up memory symlink..."
mkdir -p "$(dirname "$MEMORY_TARGET")"
if [ -L "$MEMORY_TARGET" ]; then
  echo "  Symlink already exists: $(readlink "$MEMORY_TARGET")"
elif [ -d "$MEMORY_TARGET" ]; then
  echo "  WARNING: $MEMORY_TARGET is a directory (not a symlink)."
  echo "  Backing up existing memory to $MEMORY_TARGET.bak"
  mv "$MEMORY_TARGET" "$MEMORY_TARGET.bak"
  ln -s "$REPO_DIR/memory" "$MEMORY_TARGET"
  echo "  Symlink created. Review .bak directory and merge any newer files."
else
  ln -s "$REPO_DIR/memory" "$MEMORY_TARGET"
  echo "  Symlink created: $MEMORY_TARGET -> $REPO_DIR/memory"
fi

# 2. Clone thunderid reference repo (shallow)
echo "[2/3] Cloning thunderid reference repo..."
if [ -d "$REPO_DIR/thunderid/.git" ]; then
  echo "  Already cloned. Fetching latest..."
  cd "$REPO_DIR/thunderid"
  git fetch --depth 1 origin main && git reset --hard origin/main
else
  git clone --depth 1 https://github.com/thunder-id/thunderid.git "$REPO_DIR/thunderid"
fi

# 3. Run initial GitHub sync
echo "[3/3] Running initial GitHub state sync..."
if command -v gh &> /dev/null; then
  chmod +x "$REPO_DIR/scripts/sync-github-state.sh"
  "$REPO_DIR/scripts/sync-github-state.sh"
  echo "  GitHub state synced."
else
  echo "  WARNING: gh CLI not found. Install it and run scripts/sync-github-state.sh manually."
fi

echo ""
echo "=== Setup complete ==="
echo "Open this directory in Claude Code to start discussing ThunderID."
echo "Memory, hooks, and GitHub sync are all configured."
