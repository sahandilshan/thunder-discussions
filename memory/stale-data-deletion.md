---
name: stale-data-deletion
description: Discussion
metadata: 
  node_type: memory
  type: project
  originSessionId: b81d3aed-a835-41df-9051-219facd0f1c0
---

Discussion #3181 by rajithacharith (parent issue #1859): "Handling stale data when deleting resources."

**Design:** classify each resource relationship as ownership (hard → cascade-delete dependents in delete txn) or reference (soft → keep dangling ID, resolve to system default at read time). Adds informational `GET /api/v1/{resource-type}/{id}/usages` endpoint (non-gating) to drive a pre-delete UI confirmation dialog. Rejected blocking deletion and gating on usages.

**Feedback Sahan posted (2026-06-08):**
1. Add a third behavior `restrict` (SQL trio CASCADE/SET DEFAULT/RESTRICT). flow and theme are both reference→fallback but unequal — theme fallback is cosmetic, flow fallback is behavioral (silent revert to default flow can drop MFA = security regression). References with no safe default should block, not degrade.
2. No decision rule for HARD vs SOFT. `behaviorOnDelete` should be a property of the *relationship/edge* (A→B), not the resource — same resource can cascade from one parent and be a soft ref from another.
3. Second-order blast radius: `GET A/usages` shows only direct dependents; cascade-deleting B strands soft-refs pointing at B that silently fall back — preview should surface transitive impact.

Open questions in design: pagination strategy (cursor vs offset) for usages; concurrency (re-validate at delete time vs let fallback/cascade absorb).
