# IAM × AI Competitive Intelligence Operation — Design

**Date:** 2026-06-09
**Owner:** Sahan
**Status:** Approved for build

## Purpose

Establish an ongoing intelligence operation so Sahan can own "IAM for AI" and "AI for IAM" within ThunderID. The operation continuously monitors what the full identity ecosystem is doing in these two domains, cross-references against ThunderID's existing capabilities, and feeds three outputs from a single research pipeline:

1. **Competitive positioning** — where ThunderID leads and where gaps exist
2. **Feature roadmap input** — prioritized capabilities the market is moving toward
3. **Thought leadership** — research-backed content positioning ThunderID as the authority

ThunderID already has a baseline (first-class agent identity, MCP support, composable flow engine). This operation builds the *external radar* the baseline lacks.

## Two Domains

| Domain | Definition |
|--------|-----------|
| **IAM for AI** | Securing agents, MCP, A2A, machine/workload identity, agent-to-agent auth, delegated authorization for agents, capability-scoped tokens for AI |
| **AI for IAM** | Using AI to improve IAM itself — natural-language policy, anomaly detection, intelligent provisioning, AI-assisted threat response, LLM-driven consent, IAM config copilots |

## Vendor Tiers (full ecosystem)

| Tier | Entities |
|------|----------|
| **Enterprise IAM** | Auth0/Okta, Entra ID, Ping Identity, ForgeRock, AWS Cognito, GCP IAM, Keycloak |
| **AI-native / Modern** | Stytch, WorkOS, Descope, Clerk, Pangea, Crossmint, Arcjet, plus protocol originators (Anthropic MCP, Google A2A, Microsoft agent identity) |
| **Adjacent infra** | Kong, Apigee (API gateways); SPIFFE/SPIRE, Istio (service mesh identity); HashiCorp Vault, Infisical (secrets); IETF OAuth WG, OpenID Foundation, FIDO Alliance (standards) |

## Capability Matrix (tracking columns)

1. Agent identity model (first-class entity? service account? new primitive?)
2. Agent authentication (client credentials, mTLS, DPoP, token binding)
3. Agent authorization (scoping, delegation, consent, least-privilege)
4. MCP support (server registration, client auth, DCR, CIMD)
5. A2A / agent-to-agent protocols
6. Workload identity (SPIFFE, cloud workload identity federation)
7. Token security for AI (short-lived, audience-restricted, capability-scoped)
8. AI-powered admin capabilities
9. AI threat detection / anomaly
10. Standards participation (IETF drafts, OpenID specs authored/implemented)

## Architecture: Scout + Synthesis (Hybrid)

### Component 1 — Daily Scout (automated, cloud)

- **Mechanism:** A scheduled remote agent (claude.ai routine), runs in Anthropic's cloud — **does not require Sahan's laptop to be on**.
- **Schedule:** Daily at 2:00 AM Asia/Colombo = `0 20 * * *` UTC.
- **Model:** Sonnet 4.6 (cheap detection sweep).
- **Job:** Signal *detection*, not deep analysis. Scans vendor blogs, changelogs, spec repos, GitHub releases, HN, standards lists for changes since the last signals file. Writes `intelligence/signals/YYYY-MM-DD.md` with what's new and flags high-signal items.
- **Persistence:** Commits the signals file directly to the `thunder-discussions` repo.
- **Constraint:** Headless, no `gh` access to the `thunderid` code repo. External world only.

### Component 2 — Interactive Deep-Dive (Sahan-initiated, Opus)

- **Trigger:** Sahan opens a session and says "research today" (or similar).
- **Job:** Read latest signals → run the deep-research harness (fan-out search, fetch real sources, adversarial verification, cited synthesis) on interesting items → cross-reference against ThunderID (live `gh` + memory) → discuss/challenge → synthesize into `knowledge-base/`.
- **Output:** Updated vendor KB files; optional `briefs/` deep-dive documents.

## Research Protocol (the standard for every deep-dive)

The deep-research harness, applied in source-quality layers:

1. **Layer 1 — Primary sources:** vendor docs, changelogs, spec repos (MCP, A2A, IETF drafts), GitHub releases. Ground truth, dated.
2. **Layer 2 — Announcements:** vendor blogs, conference talks, launch posts. Claims.
3. **Layer 3 — Community reality check:** HN, practitioner blogs, GitHub issues. Marketing vs. reality.
4. **Layer 4 — ThunderID lens:** cross-reference findings against ThunderID's actual capabilities; identify gaps.

Then an **adversarial verification pass** tries to refute each claim before it lands.

**Hard rules:**
- Nothing enters the knowledge base unless freshly searched and **cited** (URL + date).
- Training-data recall is never used for vendor claims (cutoff is stale in this fast-moving field).
- Inference (e.g., from job postings, spec contributions) is flagged as inference, not fact.

## File Structure

```
thunder-discussions/
├── intelligence/
│   ├── TAXONOMY.md              # vendor × capability matrix (the map)
│   ├── knowledge-base/          # one file per vendor, accumulated cited truth
│   ├── signals/                 # daily scout output, one file per day
│   ├── briefs/                  # deep-dive synthesis from sessions
│   └── SCOUT-PROMPT.md          # exact instructions the 2am agent runs
└── docs/superpowers/specs/
    └── 2026-06-09-iam-ai-intelligence-operation-design.md
```

## Optional Enhancements (decide later)

- Scout pushes a daily summary to Slack or Gmail (connectors available to routines).
- Staleness tracking in `TAXONOMY.md` (last-verified date per vendor/capability cell).

## Success Criteria

- Daily signals files accumulate automatically without manual effort.
- Knowledge base grows into a cited, queryable competitive picture across all tiers.
- Each deep-dive can produce positioning, roadmap, or content output on demand.
- Sahan can answer "what is vendor X doing on capability Y, as of when, with what source?" instantly.
