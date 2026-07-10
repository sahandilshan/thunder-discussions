---
name: id-jag-support
description: ID-JAG (Identity Assertion JWT Authorization Grant) spec analysis and design discussion for ThunderID cross-app access
metadata: 
  node_type: memory
  type: project
  originSessionId: 4166fe58-603e-4398-b879-06e766f6ccf0
---

## ID-JAG Support in ThunderID

Issue #2440 (milestone 0.48.0), Discussion #3902 (Design category, created 2026-07-10).

**Why:** Enables cross-app access (XAA) — user authenticates at one IdP, client programmatically accesses resources at a different AS without user interaction. Solves SaaS-to-SaaS integration and AI agent authorization gaps.

**How to apply:** ID-JAG is a profile on top of Token Exchange (RFC 8693), not a replacement. ThunderID needs both roles: IdP (issuing ID-JAGs) and Resource AS (consuming ID-JAGs).

### Key Spec Findings (verified against draft)
- ID-JAG is a signed JWT (`oauth-id-jag+jwt`), analogous to an authorization code — intermediate grant, not an access credential
- Requires pre-configured trust triangle: Client ↔ IdP, Client ↔ Resource AS, IdP ↔ Resource AS
- Scope handling: IdP sets ceiling, Resource AS sets floor; absent scope = no ceiling (Resource AS decides freely)
- User pre-existence at Resource AS: NOT mandatory; JIT provisioning is MAY, not MUST
- Same absent-claim pattern for `resource` and `authorization_details`
- `client_id` in ID-JAG is the client's ID at the Resource AS (may differ from IdP-side ID) — IdP needs out-of-band mapping

### Open Design Questions (in #3902)
1. Scope handling when absent — default scopes vs grant all vs reject
2. User provisioning strategy — reject vs JIT vs configurable per issuer
3. Trusted issuer management (ties to #3508)
4. Client ID mapping approach
5. RAR support — defer or include
6. Replay protection (`jti`) storage strategy
7. Relationship to #2861 (audience injection bug)
8. Multi-tenant mapping to ThunderID's org model

### Related Issues
- [[rfc8707-resource-indicators]] — resource claim in ID-JAG
- [[agent-identity-tokens]] — ID-JAG relevant for agent-to-app auth gaps
- #2172 (Token Exchange), #2176 (JWT Bearer), #3508 (Trusted Issuer), #2861 (audience injection)
