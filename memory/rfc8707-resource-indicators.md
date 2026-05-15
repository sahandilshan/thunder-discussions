---
name: rfc8707-resource-indicators
description: "RFC 8707 implementation status — resource parameter mapped to Resource Server entity, three open blockers"
metadata: 
  node_type: memory
  type: project
  originSessionId: bed1d0e5-f06f-4da6-9373-8f7a77263f1f
---

Implementing resource indicator support (RFC 8707) in Thunder. Design concluded: the `resource` parameter maps to Thunder's "Resource Server" entity (not sub-level Resources).

**Proposed solution:** Two distinct fields on Resource Server:
- `identifier` — simple string for permission string prefixing (e.g., `booking-api:users:read`)
- `uri` — absolute URI for the `resource` parameter and `aud` claim
- Uses `#` as delimiter where URI embedding in scope strings is needed (RFC 8707 prohibits fragment components in resource URIs, making `#` safe and unambiguous)

**Key design principle:** The `resource` parameter is about audience restriction ("where"), while scopes/permissions handle access rights ("what") — these must remain separated.

**Open blockers (unresolved):**
1. Single-value `aud` claims — need multi-audience support
2. Permission string collisions across Resource Servers
3. Resource Server identifiers not being URIs

**How to apply:** These three blockers are the immediate priority for RFC 8707 progress. Any discussion touching resource indicators, audience claims, or scope design should reference this context.

Related: [[thunderid-overview]], [[auth-claims-jwt]], [[design-principles]]
