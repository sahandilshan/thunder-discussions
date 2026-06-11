---
name: resource-server-ux-rethink
description: Discussion #3182 — Resource Server first-class Console UI, phased approach (UI first, then role→permission)
metadata: 
  node_type: memory
  type: project
  originSessionId: 4face505-5ee9-4340-9a8e-954a90917a5d
---

Discussion #3182 rewritten 2026-06-11: "Resource Server UI — First-Class Console Representation"

**Current state:** No Resource Server UX exists in the Console. All RS config is done outside the UI.

**Phase 1 — Resource Server Console UI:**
1. RS listing page — Name, Type (API/MCP/Custom), Identifier, Handle with type badges and icons
2. RS detail page — resource hierarchy as expandable tree (resources → sub-resources → actions), permission strings (e.g., `ecommerce.products`), immutable handles
3. Add Resource dialog — Name, Handle (immutable), Description

**Phase 2 — Role → Permission assignment:**
- Assign RS permissions to roles in Console (Permissions tab on role edit page)
- Three interaction patterns explored in comment #17261232

**Why:** The Console needs a visual way to manage resource servers and their permission hierarchies before any backend type system or RFC 8707 changes matter to end users. UI-first approach.

**How to apply:** Related to #2973 (MCP as RS template), #2966 (MCP first-class support), #2413 (Resource Management UI), #2059 (role/resource/scope management UI). See [[rfc8707-resource-indicators]], [[scope-rs-audience-resolution]].
