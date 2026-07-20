---
name: trusted-token-issuers-connection
description: Issue
metadata: 
  node_type: memory
  type: project
  originSessionId: 9e368438-4cde-4ad5-8c69-87b23c120e77
---

Moving token-exchange trusted-issuer registration off the legacy `/identity-providers` API onto the `/connections` surface.

- **Issue #4109** (`Type/New Feature`, `Theme/STS`) — the "main" feature issue introducing a dedicated `/connections/trusted-token-issuers` path.
- **Discussion #4110** (Design) — design rationale + open questions.

**Design decided (2026-07-17):** Trusted token issuer = a **connection with a token-exchange-trust capability** (data model), exposed via a **typed façade** at `/connections/trusted-token-issuers` (API surface). No parallel entity — reuses connection issuer URL / JWKS / claim mapping. Inbound-only issuers (GitHub Actions OIDC, SPIFFE, WIF) = connections whose only enabled capability is trusted-token-issuer, no outbound login config. This reconciles Sahan's two answers (capability model + dedicated path).

**Still open in the discussion:** nesting `/connections/...` vs top-level `/trusted-token-issuers` (Claude leaned top-level = honest about inbound trust direction); claim-mapping reuse vs distinct block; how to expose `trustedTokenAudience` in the public OIDC contract; migration from `/identity-providers`; naming (`trusted-token-issuers` vs overloaded `trusted-issuers`).

**Origin:** resolves #3835 item 1 (uniform trusted-issuer config onto connections API). Depends on [[event-publishing]]-unrelated; coordinates with #4031 gap 1 (`trustedTokenAudience` contract) and #3992 (retire legacy `/identity-providers` CRUD). Follows #3508 (original trusted issuer onboarding, delivered on legacy surface). No one CC'd per Sahan.
