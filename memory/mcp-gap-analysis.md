---
name: mcp-gap-analysis
description: Full MCP review 2026-07-02 — what ThunderID has (backend+UI) vs MCP spec world; CIMD is the
metadata: 
  node_type: memory
  type: project
  originSessionId: 42f56801-5151-4f60-967f-e5f974b7dfcb
---

Thorough MCP review done 2026-07-02 (code verified against local HEAD 6f8d8b515, "MCP-native Capabilities view", issue #3465).

**Spec state (July 2026):** Current MCP spec 2025-11-25; 2026-07-28 revision is a locked RC (final July 28, 2026) that **formally deprecates RFC 7591 DCR in favor of CIMD**. Compliance floor for an MCP-ready AS: OAuth 2.1 + discovery advertising PKCE, RFC 8707, CIMD (`client_id_metadata_document_supported`), scope-challenge/step-up (401 scope hint + 403 insufficient_scope), RFC 9207 iss. Enterprise-managed authorization (ID-JAG, draft-ietf-oauth-identity-assertion-authz-grant-04) is a stable ext-auth extension; SEP-1028 downstream auth closed unaccepted (token vaults fill the gap). SEP-2385 (per-tool auth manifest) open.

**ThunderID HAS (verified in code):** RS entity with type API|MCP|CUSTOM + identifier URI (providers/model.go); Action.Kind tool|resource; RFC 8707 full (resourceindicators.go: validate, ResolveAndDownscope, ComposeAudiences, refresh narrowing); RFC 8414 discovery; DCR at `/oauth2/dcr/register`; RFC 8693 token exchange with actor tokens + act claim (IncludeActClaim; agents always); PKCE S256; RFC 9207 iss in authz responses (authz/handler.go:71); agent entity w/ auto-provisioned OAuth client; own MCP server at /mcp with RFC 9728 PRM (system-only, root permission scope); Wayfinder sample (17 tools, per-tool scopes, act-claim logging, CIBA upgrade agent). Console: MCP RS type + Capabilities tree (tools/resources/namespaces), permission catalog with MCP sections, agents UI, MCP tryout page.

**TOP GAPS (ranked):**
1. **CIMD — zero support**, and DCR (just built) goes deprecated July 28. Auth0/Stytch/WorkOS/Descope shipped CIMD; Keycloak experimental; Entra committed. **Issue #2975, Discussion #3692 created 2026-07-02.**
2. **PRM/validation story for CUSTOMER MCP servers** — Thunder serves RFC 9728 only for its own /mcp; customers must hand-roll PRM + token validation (no Thunder MCP middleware/SDK; Wayfinder hand-rolls in JS). PRM `scopes_supported` should derive from the Capabilities model.
3. **Scope discovery & step-up** — no 401 scope hints / 403 insufficient_scope flow (normative in 2025-11-25).
4. **App/agent ↔ RS binding UI** — Capabilities can be authored but not granted: app/agent scope entry is manual text; no RS browse, no audience field, no app-to-RS inventory. Backend has no MCP-client marker either (arguably fine — real gap is binding UX, not a type label).
5. **Enterprise-managed auth (ID-JAG/XAA)** — nothing on either side (no jwt-bearer *grant type*, no authorization_grant_profiles_supported). Okta/WorkOS EA; differentiator not floor.
6. **Outbound token vault** for MCP servers calling upstream APIs (Auth0 Token Vault / Descope Outbound Apps analogue) — differentiator.
7. Smaller: DPoP flag exists but enforcement unverified; consent UI granularity for tool scopes; system RS /mcp audience hack still open (#3261).

**Vendor snapshot:** Auth0 Auth for MCP GA 5/2026 (per-tool scopes, CIMD, Token Vault, CIBA+RAR); Okta XAA/ID-JAG EA + Okta for AI Agents GA 4/2026; Entra Agent ID GA (fmi_path two-stage OBO; no DCR/CIMD/8707); Stytch/WorkOS CIMD GA; Descope Agentic Identity Hub 2.0 (per-tool scopes, outbound apps); Keycloak partial (8707 experimental, CIMD experimental 26.6).

**How to apply:** ThunderID's RFC 8707+8693+agent+act story is ahead of most vendors; the misses are CIMD, customer-MCP-server enablement (PRM+SDK+step-up), and binding UX. Any MCP roadmap discussion should start from this ranking. Full briefs in session 42f56801 task outputs.

Related: [[resource-server-ux-rethink]], [[system-rs-representation]], [[scope-rs-audience-resolution]], [[rfc8707-resource-indicators]], [[agent-identity-tokens]], [[agent-as-subject]], [[multi-agent-hierarchy]]
