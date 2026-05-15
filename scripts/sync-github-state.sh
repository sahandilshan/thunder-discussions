#!/bin/bash
# Syncs thunderid GitHub state into the discussion project memory.
# Throttled: only runs if last sync was >12 hours ago.

MEMORY_DIR="$HOME/.claude/projects/-Users-sahandilshan-IAM-thunder-developments-thunder-discussions/memory"
MEMORY_FILE="$MEMORY_DIR/github-project-state.md"
TIMESTAMP_FILE="$MEMORY_DIR/.last-github-sync"
REPO="thunder-id/thunderid"
THROTTLE_SECONDS=43200  # 12 hours

if [ -f "$TIMESTAMP_FILE" ]; then
  LAST_SYNC=$(cat "$TIMESTAMP_FILE")
  NOW=$(date +%s)
  ELAPSED=$((NOW - LAST_SYNC))
  if [ "$ELAPSED" -lt "$THROTTLE_SECONDS" ]; then
    exit 0
  fi
fi

ISSUES=$(gh issue list -R "$REPO" --limit 50 --json number,title,labels,state 2>/dev/null) || exit 0
MILESTONES=$(gh api "repos/$REPO/milestones" --jq '.[] | "\(.title) due:\(.due_on // "none") open:\(.open_issues) closed:\(.closed_issues)"' 2>/dev/null) || true
DISCUSSIONS=$(gh api graphql -f query='{ repository(owner:"thunder-id", name:"thunderid") { discussions(first:20, orderBy:{field:CREATED_AT, direction:DESC}) { nodes { title number category { name } } } } }' --jq '.data.repository.discussions.nodes[] | "#\(.number) \(.title) [\(.category.name)]"' 2>/dev/null) || true
RELEASES=$(gh release list -R "$REPO" --limit 3 --json tagName,publishedAt,name --jq '.[] | "\(.tagName) \(.publishedAt) \(.name)"' 2>/dev/null) || true

TOTAL_OPEN=$(echo "$ISSUES" | jq 'length' 2>/dev/null || echo "?")
BUGS=$(echo "$ISSUES" | jq '[.[] | select(.labels[]?.name == "Type/Bug")] | length' 2>/dev/null || echo "?")
FEATURES=$(echo "$ISSUES" | jq '[.[] | select(.labels[]?.name == "Type/New Feature")] | length' 2>/dev/null || echo "?")
IMPROVEMENTS=$(echo "$ISSUES" | jq '[.[] | select(.labels[]?.name == "Type/Improvement")] | length' 2>/dev/null || echo "?")

TODAY=$(date +%Y-%m-%d)
LATEST_RELEASE=$(echo "$RELEASES" | head -1)

cat > "$MEMORY_FILE" << MEMEOF
---
name: github-project-state
description: GitHub repo state auto-synced on $TODAY — milestones, labels, discussions, release cadence, issue templates
metadata:
  type: project
---

Auto-synced on $TODAY. Verify with \`gh\` CLI for real-time state.

## Open Issues Summary

Total open: $TOTAL_OPEN | Bugs: $BUGS | Features: $FEATURES | Improvements: $IMPROVEMENTS

## Milestones

$MILESTONES

## Latest Releases

$RELEASES

## Recent Discussions (newest first)

$DISCUSSIONS

## Labels (36 total)

- **Type/**: Bug, Improvement, New Feature, Task, UX, Question, Docs
- **Severity/**: Blocker, Critical, Major, Minor, Trivial
- **Priority/**: Highest, High, Normal, Low
- **Resolution/**: Fixed, Duplicate, Won't Fix, Cannot Reproduce, Not a bug, Invalid, Postponed
- **Credits/**: 20, 30, 45

## Issue Templates

- **bug.yml** → auto-labels \`Type/Bug\`
- **feature.yml** → auto-labels \`Type/NewFeature\` (problem-first: what, who, why, solution, alternatives)
- **improvement.yml** → auto-labels \`Type/Improvement\`
- **doc-issue.yml** → auto-labels \`Type/Docs\`

## Discussion Template

- **design.yaml** → linked feature issue, problem summary, architecture, security, impacted areas, alternatives

**How to apply:** Use these templates when creating issues/discussions. Check milestones when triaging. Reference active discussions to avoid duplicates.

Related: [[thunderid-overview]], [[collaborators-and-references]]
MEMEOF

date +%s > "$TIMESTAMP_FILE"
