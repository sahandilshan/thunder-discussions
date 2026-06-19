---
name: spiffe-client-auth
description: SPIFFE-based client authentication — Issue
metadata: 
  node_type: memory
  type: project
  originSessionId: 0672bf16-8185-46c3-a908-0b5e90bdbee3
---

SPIFFE-based client authentication for ThunderID, implementing `draft-ietf-oauth-spiffe-client-auth-02`.

**Artifacts:**
- Feature Issue: #3387
- Design Discussion: #3388
- SPIFFE primer doc: `docs/spiffe-primer.md` (in this repo, covers fundamentals + vendor landscape)

**Three client authentication mechanisms (phased):**
1. `spiffe_jwt` (Phase 1) — JWT-SVID as `client_assertion`, lowest barrier
2. `spiffe_x509` (Phase 2) — X.509-SVID via mTLS
3. `spiffe_wit` (Phase 3) — Workload Identity Token, spec still evolving

**Key architectural decision:** ThunderID does NOT run a SPIFFE agent or sit in the SPIFFE path. It connects only to the SPIFFE Bundle Endpoint (OIDC Discovery Provider) to fetch JWKS/root CAs for SVID validation — same pattern as fetching any external JWKS.

**Why:** Eliminates static client secrets for workload auth; aligns with zero-trust; IETF standardization in progress; connects to agent identity work ([[agent-identity-tokens]]).

**How to apply:** When discussing workload identity, M2M auth, or AI agent authentication, reference this as the direction for secret-less client auth. Phase 1 (`spiffe_jwt`) should be prioritized.

**Competitive context:** Keycloak has preview-level SPIFFE support (JWT-SVID only, since v26.4.0). ThunderID aims to be first open-source OAuth server with full IETF draft coverage (all three mechanisms) at GA.

**Open questions (in discussion #3388):**
1. Multiple SPIFFE trust domains per deployment vs one per tenant?
2. Many-to-one SPIFFE ID → client mapping for workload replicas?
3. Interaction with existing M2M identity features?
4. mTLS termination strategy for `spiffe_x509` (direct vs proxy forwarding)?
5. Connection to agent identity claims (#3128)?
