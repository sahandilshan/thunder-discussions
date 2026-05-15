---
name: auth-claims-jwt
description: Authorization claims design for JWT tokens — issue
metadata: 
  node_type: memory
  type: project
  originSessionId: bed1d0e5-f06f-4da6-9373-8f7a77263f1f
---

Design for how roles and permissions are represented in access and ID tokens (GitHub issue #1931).

**Key decisions made:**
- Permissions omitted from tokens — scope handles it
- App-level roles scoped to the authenticating application's context
- Aligned with Thunder's entity model
- `authorization_details` with custom `thunder_org_access` type for OU-level roles (RFC 9396)

**Status:** GitHub discussion initiated. Community feedback from @thiva-k and @shashimalcse was addressed.

**Design principle:** Permissions belong in scopes, not in JWT token claims — token claims should carry role/authorization context only.

**How to apply:** Any future token design discussion should build on these decisions. Changes to this model need re-evaluation against the scope/permission separation principle.

Related: [[rfc8707-resource-indicators]], [[thunderid-overview]], [[design-principles]]
