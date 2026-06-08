---
name: resource-server-ux-rethink
description: Discussion
metadata: 
  node_type: memory
  type: project
  originSessionId: 4face505-5ee9-4340-9a8e-954a90917a5d
---

Discussion #3182 created 2026-06-07: "Rethink Resource Server Console UX: Types, Naming, and Cleanup"

**Decisions made:**
1. Rename "APIs" to "Resource Servers" throughout Console (sidebar, routes, i18n)
2. Add `type` field to ResourceServer model — `api`, `mcp`, `custom` — immutable after creation
3. No hybrid types — one RS per audience URI per RFC 8707; services exposing both API and MCP register two separate resource servers
4. Type-specific create templates auto-populate defaults (e.g., MCP suggests `{base_url}/mcp` as identifier)
5. System RS stays as single `api` type for now; split into separate API + MCP resource servers in the future
6. Remove Application Access tab (non-functional placeholder with mock data)
7. Fix empty Handle column rendering (show em-dash instead of empty Chip)
8. Add visual differentiation by type (distinct icons, type badge in list)
9. Create flow expanded: Type selection → Details (incl. Identifier) → Organization Unit

**Why:** MCP servers, databases, file systems are all resource servers, not "APIs." The current model has no type discrimination, making type-specific UX impossible. The create flow is too minimal — Identifier (audience) isn't even asked at creation time.

**How to apply:** Related to #2973 (MCP as RS template), #2966 (MCP first-class support), #2413 (Resource Management UI). Backend needs DB migration, model change, DTO updates. Frontend needs full rename + create wizard rework.

**Security note:** Single System RS means tokens are interchangeable between management API and MCP — acceptable for now but should be split when audience enforcement is added to the management API. See [[rfc8707-resource-indicators]].
