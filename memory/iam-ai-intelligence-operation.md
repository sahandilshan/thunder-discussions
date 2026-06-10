---
name: iam-ai-intelligence-operation
description: Daily automated scout (2 AM Opus 4.8) + interactive deep-dives for IAM×AI competitive intelligence across 26 vendors
metadata: 
  node_type: memory
  type: project
  originSessionId: 14727c96-d7d9-462b-8da2-ac30ee988763
---

An ongoing intelligence operation monitoring "IAM for AI" and "AI for IAM" across the full identity ecosystem, feeding ThunderID positioning, roadmap, and thought leadership.

**Why:** Sahan wants to own both domains in ThunderID. Requires continuous external radar — what vendors are doing, what specs are emerging, where ThunderID leads or has gaps.

**How to apply:** When Sahan says "research today" or similar, read the latest `intelligence/signals/` file and run the deep-research harness on interesting items. Cross-reference against ThunderID via `gh`. Synthesize into `intelligence/knowledge-base/` vendor files. Every claim must be freshly searched and cited — never use training-data recall for vendor claims.

## Architecture

- **Daily scout**: Cloud routine `trig_01UEpDdMSzQurXVAvP35ohLf`, runs at 2:00 AM Colombo (cron `30 20 * * *` UTC), model Opus 4.8. Commits `intelligence/signals/YYYY-MM-DD.md` to `sahandilshan/thunder-discussions` main branch. No laptop required.
- **Interactive deep-dive**: Sahan-initiated, runs locally with full `gh` access. Uses deep-research harness (fan-out search, fetch real sources, adversarial verification, cited synthesis).

## Key files

- `intelligence/TAXONOMY.md` — vendor × capability matrix (26 vendors, 10 capabilities)
- `intelligence/SCOUT-PROMPT.md` — exact instructions the routine runs
- `intelligence/knowledge-base/` — one file per vendor, accumulated cited truth
- `intelligence/signals/` — daily scout output
- `intelligence/briefs/` — deep-dive synthesis
- Design spec: `docs/superpowers/specs/2026-06-09-iam-ai-intelligence-operation-design.md`

## Routine management

- View/manage: https://claude.ai/code/routines/trig_01UEpDdMSzQurXVAvP35ohLf
- To change scout behavior: edit `intelligence/SCOUT-PROMPT.md` and push — no routine update needed.
- To change model/schedule: update the routine via `RemoteTrigger` tool.

Related: [[mcp-iam-vendor-research]], [[thunderid-overview]], [[codebase-architecture]]
