---
name: mcp-agent-tools-design
description: "Task-oriented MCP toolset design for agent management (issue #2409) — 9 tools, deliberately NOT 1:1 CRUD"
metadata: 
  node_type: memory
  type: project
  originSessionId: 64c1f0f6-f78f-40d9-9fcf-d6900bcffe13
  modified: 2026-07-20T09:52:41.482Z
---

Design work for issue #2409 (Add MCP tools for agent management), session 2026-07-20. Sahan explicitly wants task-oriented tools, NOT 1:1 API/CRUD mapping — note #2409's own body and umbrella #3112 propose exactly the CRUD mapping we're rejecting; both may need updating if this design is accepted.

**Codebase facts verified 2026-07-20 (HEAD 795bb37e1):**
- MCP server: official Go SDK, streamable HTTP at /mcp, tools call domain services in-process (`backend/internal/system/mcp/`), 16 existing tools, zero agent tools. Auth = single coarse root scope ("system"), RFC 9728 PRM served; no per-tool scopes.
- Agent = entity (category "agent") + auto-provisioned inbound OAuth client + roles/groups + OU + owner + schema attributes (singleton `default` agent type). client_credentials token: sub = agent entity ID, scopes downscoped to one RS (RFC 8707) then filtered by role/group access evaluation. Agents ALWAYS append `act` claim on user tokens (delegated mode).
- REST has NO secret-rotation endpoint — console fakes it client-side (GET agent → generate 32-byte secret in browser → PUT full agent). PUT is full-replacement (dangerous for LLM callers).
- No agent↔RS scope-binding UI exists; "what can this agent access" is answerable nowhere in one call.
- Auth methods: client_secret_basic/post, private_key_jwt (needs JWKS/JWKS_URI cert), none (public+PKCE). No SPIFFE anywhere.
- Delegated mode = adding authorization_code (+ ciba, refresh_token); requires redirect URIs + allowedUserTypes + auth flow. Declarative agents are read-only (AGT-1027).

**Proposed 9-tool set (thunderid_ prefix):** find_agents, inspect_agent (consolidated view incl. effective access roles→permissions→RS), create_agent (mode-aware: `mode: direct|delegated` — Sahan's refinement 2026-07-20; delegated requires redirectUris+allowedUserTypes at create, one POST does it all; direct defaults client_credentials+basic, one-time secret), update_agent_profile (patch semantics), rotate_agent_credentials (proper server-side rotation — new service capability), configure_agent_auth (method+cert invariants enforced), configure_agent_delegation (narrowed to mode TRANSITIONS on existing agents), manage_agent_access (grant/revoke roles+groups by name, cross-domain), delete_agent. Plus: agent-type schema as MCP *resource*, not a tool. Boundary principle: create covers intrinsic identity+auth config, NOT relationships (no roles/groups at create — partial-failure risk).

**Open questions:** client secrets in MCP tool results persist in LLM context/transcripts (mitigation: prefer private_key_jwt, flag sensitive); per-tool authorization missing (root scope only — high stakes for credential-minting tools); umbrella #3112's "no new business logic" acceptance criterion conflicts with rotation + effective-access needing new service methods; whether to update #2409 body/post design as comment (not yet done — Sahan hasn't approved posting).

Related: [[mcp-gap-analysis]], [[agent-identity-tokens]], [[agent-as-subject]], [[multi-agent-hierarchy]], [[design-principles]]
