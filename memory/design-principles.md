---
name: design-principles
description: Established design principles and learnings from Thunder design discussions
metadata: 
  node_type: memory
  type: feedback
  originSessionId: bed1d0e5-f06f-4da6-9373-8f7a77263f1f
---

Principles established through prior design work on Thunder:

1. **Scope vs. claims separation:** Permissions belong in scopes, not JWT claims. Token claims carry role/authorization context only.
2. **Resource vs. audience separation:** The `resource` parameter (RFC 8707) is about audience restriction ("where"), scopes/permissions handle access rights ("what") — never conflate them.
3. **Avoid over-engineering:** Start with simpler patterns, design abstractions that allow future migration. Don't add message queues to a single-service architecture.
4. **`#` as scope delimiter:** RFC 8707 prohibits fragment components in resource URIs, making `#` safe and unambiguous for embedding Resource Server identity in scope strings.
5. **OTel separation of concerns:** Instrumentation in code, data management at collector level. Prefer collector-level filtering over SDK-level.

**Why:** These emerged from deep design analysis cross-referencing RFCs, industry patterns (Okta, Auth0, Keycloak, Entra ID, AWS Cognito, GCP), and Thunder's own architecture.

**How to apply:** Treat these as load-bearing decisions. New proposals that contradict them need explicit justification, not silent deviation.

Related: [[rfc8707-resource-indicators]], [[auth-claims-jwt]], [[event-publishing]]
