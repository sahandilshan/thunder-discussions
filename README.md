# Thunder Discussions

A non-code discussion hub for [ThunderID](https://github.com/thunder-id/thunderid). Used for brainstorming features, architecture decisions, issue/discussion management, and project planning through Claude Code.

## Setup (Fresh Machine)

```bash
git clone git@github.com:sahandilshan/thunder-discussions.git
cd thunder-discussions
./setup.sh
```

This will:
1. Create a symlink from `~/.claude/projects/.../memory/` → `./memory/` so Claude Code loads shared memory automatically
2. Shallow-clone the thunderid repo for code reference
3. Run the initial GitHub state sync (requires `gh` CLI authenticated)

Then open this directory in Claude Code to start discussing.

## How It Works

### Memory System

All discussion context (decisions, design principles, active work streams) lives in `memory/`. Claude Code reads these automatically at the start of every chat session via a symlink to `~/.claude/projects/`.

### Auto-Sync Hook

On every message in Claude Code, a hook automatically:
1. **Fetches latest thunderid code** — shallow git fetch + reset
2. **Syncs GitHub state** — milestones, issues, discussions, releases (throttled to once per 12 hours)
3. **Backs up to this repo** — commits and pushes memory/config changes (throttled to once per 6 hours)

### What's Tracked

| Path | Purpose |
|------|---------|
| `CLAUDE.md` | Project rules and discussion style for Claude Code |
| `memory/` | Shared memory files (auto-loaded by Claude Code) |
| `scripts/sync-github-state.sh` | Fetches GitHub state into memory |
| `scripts/auto-backup.sh` | Auto-commits and pushes changes |
| `.claude/settings.json` | Hook configuration |
| `setup.sh` | Full environment restore script |

### What's NOT Tracked

| Path | Reason |
|------|--------|
| `thunderid/` | Re-cloned by `setup.sh` (large, shallow clone) |
| `memory/.last-github-sync` | Local throttle timestamp |
| `.last-backup` | Local throttle timestamp |

## Prerequisites

- [Claude Code](https://claude.ai/code) CLI or VS Code extension
- [GitHub CLI](https://cli.github.com/) (`gh`) authenticated with access to `thunder-id/thunderid`
- Git with SSH access to this private repo

## Project Rules

- **No code here.** All code lives in [thunder-id/thunderid](https://github.com/thunder-id/thunderid).
- **Challenge ideas.** Claude is instructed to argue back with valid counter-arguments, not just agree.
- **Auto-persist.** Every chat session auto-updates memory with decisions, action items, and open questions.
