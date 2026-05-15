---
name: oauth-as-flows-vision
description: "Long-term plan to make OAuth grants pluggable as flows in ThunderID's flow engine"
metadata: 
  node_type: memory
  type: project
  originSessionId: 9f812337-c650-4544-ac44-77e35e106537
---

Long-term architectural vision: OAuth grants become fully pluggable as flows in ThunderID's flow engine.

**Grant flow pattern (established 2025-05-14):**
```
START → ClientValidator → IdentifyingExecutor (Grant Identifier) → [Grant Executor] → ... → Auth Assertion → Token Endpoint → END
```

**Per-grant shape:**
- **Auth Code Grant:** ClientValidator → IdentifyingExecutor → AuthzGrantExecutor (mandatory sub-flows: Authentication → Authorization → Auth Assertion) → Token Endpoint
- **Password Grant:** ClientValidator → IdentifyingExecutor → PwdGrantExecutor → UserResolver → Authorization → Auth Assertion → Token Endpoint
- **CIBA:** ClientValidator → IdentifyingExecutor → CIBAGrantExecutor (mandatory sub-flows: Notification Dispatch, Async User Auth [Auth → AuthZ → AuthAssert]) → Token Endpoint (poll)

**Key design principles:**
- Grant executors encapsulate grant-specific validation internally (PKCE, PAR, resource indicators) — these are NOT separate flow nodes
- Sub-flows are the composable surface (which auth method, which authorization policy)
- Token endpoint connects to Auth Assertion output — not a separate flow

**Status:** Vision only, no timeline. CIBA (#2739/#2740) is being implemented with this pattern internally as a proof point.

**Why:** Sahan confirmed this is the long-term direction. CIBA is the first grant designed with this pattern.

**How to apply:** Reference when discussing new grant types, OAuth architecture changes, or flow engine extensions.

Related: [[ciba-implementation]], [[codebase-architecture]]
