---
name: consent-scope-update
description: Issue
metadata: 
  node_type: memory
  type: project
  originSessionId: 27fdb262-33c8-4795-a9b0-fdf7bee2aa03
---

Issue #3467: Adding new scopes to an application with existing consents fails due to OpenFGC limitation (openfgc#18 — purposes can't be updated once consent records exist).

**Why:** OpenFGC's consent purpose immutability blocks legitimate scope evolution. #3176/#3189 only fixed unrelated settings triggering purpose updates; the core problem remains for actual scope changes.

**How to apply:** The proposed fix is incremental consent — prompt users only for delta scopes, create supplementary consent records, union them for effective consent. This decouples ThunderID from OpenFGC's mutability model and matches industry practice (Google, Microsoft). Related to [[oauth-as-flows-vision]] as consent handling touches the flow engine.
