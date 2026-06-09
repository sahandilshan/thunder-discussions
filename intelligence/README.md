# IAM × AI Intelligence Operation

Ongoing competitive monitoring of "IAM for AI" and "AI for IAM" across the identity ecosystem, feeding ThunderID positioning, roadmap, and thought leadership.

Design spec: [`docs/superpowers/specs/2026-06-09-iam-ai-intelligence-operation-design.md`](../docs/superpowers/specs/2026-06-09-iam-ai-intelligence-operation-design.md)

## How it works

1. **Daily scout (2 AM, automated, cloud)** — A scheduled remote agent runs `SCOUT-PROMPT.md`, detects what changed across vendors/specs, and commits `signals/YYYY-MM-DD.md`. Runs in Anthropic's cloud; your laptop does not need to be on.
2. **Interactive deep-dive (you-initiated)** — Open a session, say "research today." The deep-research harness investigates interesting signals, cross-references ThunderID, and updates `knowledge-base/`.

## Layout

| Path | Purpose |
|------|---------|
| `TAXONOMY.md` | The map — vendor × capability matrix + coverage tracker |
| `SCOUT-PROMPT.md` | Exact instructions the 2 AM routine runs |
| `knowledge-base/` | One file per vendor — accumulated, cited truth |
| `knowledge-base/_TEMPLATE.md` | Stub format for new vendors |
| `signals/` | Daily scout output, one file per day |
| `briefs/` | Deep-dive synthesis documents |

## Hard rules

- Every claim needs a **source URL + date**. No citation, no entry.
- Never use training-data recall for vendor claims — always fresh search.
- Flag inference as inference, never as fact.
