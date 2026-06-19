---
name: scope-rs-audience-resolution
description: "Discussions #3267 (implicit scope→aud resolution) & #3268 (permission string uniqueness across RSes) — created 2026-06-11"
metadata: 
  node_type: memory
  type: project
  originSessionId: 22529bae-54a4-4ff5-9595-b4ea7454b17b
---

Two coupled design discussions opened 2026-06-11 about how ThunderID maps OAuth scopes to Resource Servers (RS) and populates the `aud` claim. Split from one investigation; cross-linked.

**#3268 — Should permission strings be unique across Resource Servers?** (data-model question)
- Validated in code: NO uniqueness constraint on `RESOURCE.PERMISSION` / `ACTION.PERMISSION`; RS handle is OPTIONAL (`validateResourceServerCreate` doesn't require it); `derivePermission` prefixes with handle only when present, so handle-less RSes produce collision-prone bare permissions (`read`, `booking:read`).
- Sahan's decided stance: uniqueness considered at **deployment level only, NOT per-OU**. (Original OU-leak framing was cut from the discussion.)
- Approaches: A) make handle mandatory (structural uniqueness via prefix), B) DB `UNIQUE(PERMISSION, DEPLOYMENT_ID)`, C) allow duplicates but block authorize/token request when a scope resolves to multiple RSes.

**#3267 — Implicit scope→aud resolution vs explicit-only RFC 8707?** (behavior question)
- Validated in code: `ComposeAudiences()` (`resourceindicators.go:188-232`) does an implicit reverse lookup when no `resource` param is sent — `FindResourceServersByPermissions()` returns every RS defining the granted scopes and folds ALL their identifiers into `aud`. Reverse lookup (`store.go:865-883`) is scoped by `deploymentID` only.
- Approaches: A) explicit-only (strict RFC 8707 — `aud` only from `resource`), B) configurable toggle, C) keep implicit but refuse multiple audiences from one ambiguous scope.
- **DECISION (2026-06-19): Approach B selected.** Janak proposed B (configurable toggle); Sahan +1'd. Rationale: B is a superset of A — if implicit proves harmful later, strip it to get A; can't go A→B without building from scratch. Conditions: new deployments default to `explicit`; implicit is opt-in convenience, not recommended security posture; consider deprecation horizon.
- **Issue #3393** created to track implementation.
- Migration concerns deliberately excluded per Sahan.

**Coupling (flagged in both + relates to [[system-rs-representation]] #3261):**
- #3268 Approach A/B (global uniqueness) CONFLICTS with #3261 Approach A, which intentionally defines the *same* permissions on separate API/MCP transport RSes.
- #3267 explicit-only would make #3261's transport-token selection (`resource` param) authoritative and trivially solvable.
- #3261's "token interchangeability" consequence is the implicit-resolution problem in miniature.

**How to apply:** These are the foundational decisions; #3261 (system RS) is a downstream consumer. Any discussion on `aud`, audience restriction, scope→RS mapping, or RS handle should reference these. No CC was added (per [[feedback-no-default-cc]]).

Related: [[rfc8707-resource-indicators]], [[system-rs-representation]], [[resource-server-ux-rethink]], [[codebase-architecture]]
