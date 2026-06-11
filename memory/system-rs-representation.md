---
name: system-rs-representation
description: "Discussion #3261 — how should the system resource server represent ThunderID across API and MCP transports"
metadata: 
  node_type: memory
  type: project
  originSessionId: 44536fa3-bb42-462c-9fed-195739d2f4c3
---

Discussion #3261 created 2026-06-10: "How Should the System Resource Server Represent ThunderID?"

**Problem:** System RS has identifier `https://localhost:8090/mcp` (hack from #2812). All tokens — including API tokens — carry this MCP audience. Root cause: RS represents a logical resource domain, but `aud` is a transport-level concern. One entity can't serve both.

**Consequences:** wrong audience on API tokens, token interchangeability across transports (security gap), no way to request transport-specific tokens via RFC 8707 `resource` param.

**Two approaches proposed (no decision yet):**
- **A. Separate RSes per transport** — one API RS (`/api` audience), one MCP RS (`/mcp` audience). Clean RFC 8707 compliance. Trade-off: permission duplication.
- **B. Multiple identifiers per RS** — single RS with multiple audience URIs. No permission duplication. Trade-off: departs from 1:1 RS-to-audience model, more complex token issuance.

**History chain:** #2481 → #2812 → #2554 → #3177 → #3182 → #3261

**Why:** Elevates the system RS split from "future consideration" (#3182) to active design question.

**How to apply:** Any work on system RS identity, audience enforcement, or MCP authorization should reference this discussion. Decision here will determine bootstrap script changes, token issuance logic, and RS schema updates.

Related: [[resource-server-ux-rethink]], [[rfc8707-resource-indicators]]
