---
name: token-cleanup-discussion
description: Discussion
metadata: 
  node_type: memory
  type: project
  originSessionId: adcb2646-9fce-41f3-98f1-abab430ce81c
---

Discussion #2781 "RuntimeDB Cleanup: Hardening Expired Data Purge for Production" in thunder-id/thunderid, opened 2026-05-18.

**Key finding:** Thunder does NOT store access tokens or refresh tokens — they're self-contained JWTs. The cleanup need is for RuntimeDB transient data (auth codes, auth requests, flow contexts, WebAuthn sessions, attribute cache, PAR requests).

**Current state:** A cleanup stored procedure already exists (`postgres-cleanup.sql`) but uses naive unbounded `DELETE WHERE EXPIRY_TIME < NOW()` — no batching or chunking.

**Why:** At production scale with millions of expired rows, unbounded deletes can lock tables, bloat WAL logs, and time out — blocking the hot auth path.

**How to apply:** Discussion is open for community input on:
- Adopting chunk+batch delete pattern (WSO2-style)
- Default interval (currently suggested 60 min via pg_cron)
- Built-in app-level scheduler vs. external-only (cron/pg_cron)
- Multi-DB cleanup scripts (SQLite, MySQL beyond current PostgreSQL)
- Observability (logs/metrics from cleanup runs)

Thiva (thiva-k) commented that Thunder doesn't store tokens — discussion was reframed from "token cleanup" to "RuntimeDB cleanup hardening."

Vendor research covers: WSO2 IS, Keycloak, ForgeRock AM, PingFederate, Gluu, Ory Hydra.

Related: [[codebase-architecture]]
