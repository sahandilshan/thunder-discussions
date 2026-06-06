---
name: claim-mapping-idp
description: Discussion
metadata: 
  node_type: memory
  type: project
  originSessionId: 65a75943-0a2f-4c7f-b682-cda3ac35c82f
---

Discussion #3157 "Mapping external IdP claims to local claims" proposes an IdP-level claim mapping (stored as JSONB on the IdP entity) that normalizes external claims → local claims, reused by both **RFC 8693 token exchange** and **federated login**. Direction is external→local, applied early (before downstream claim filtering and federated-identity consistency checks). Protected names (`sub`, `iss`, `scope`) can't be mapping targets; subject identity never remapped.

Sahan and I reviewed it (commented 2026-06-05). Endorsed the core design. Three concerns raised in the reply:
1. **Pass-through default is a footgun** — proposed allowlist posture (explicit mapping required per forwarded claim) instead of silent pass-through.
2. **Precedence, not just renaming** — the real collision is mapped external value vs. existing local user attribute. Live for Thunder because JIT provisioning + account linking exist (`provisioningExecutor`, `federatedAuthResolverExecutor` in [backend/internal/flow/executor/](backend/internal/flow/executor/)). Need a per-IdP (maybe per-claim) sync/precedence policy. Token exchange differs — often no persistent local user.
3. **Shape transforms** — string↔array, `"true"`↔bool, epoch↔ISO. Design contract as `{from, to, transform?}` for v1-flat + future extensibility.

Position on open question: **skip global/default mapping**, per-IdP only.

Related: [[auth-claims-jwt]] (#1931 allowed-attributes/scope filtering must align with mapping targets), [[oauth-as-flows-vision]].
