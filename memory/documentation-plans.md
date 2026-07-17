---
name: documentation-plans
description: Doc structure proposals — persona-based docs gap, and Discussion #4100 on four-pillar structure (Quick Start / Guides / Use Cases / Reference)
metadata: 
  node_type: memory
  type: project
  originSessionId: bed1d0e5-f06f-4da6-9373-8f7a77263f1f
---

Sahan identified a gap in IAM-domain-agnostic documentation for Thunder.

**Proposed structure:** Persona-based docs covering:
- **Primary personas:** App developers (no IAM background), IAM-experienced users, Thunder contributors
- **Additional personas:** DevOps engineers, security architects, integration engineers, evaluators, migration specialists

**Why:** Current docs assume IAM familiarity. A persona-based approach lets each audience find their entry point without wading through irrelevant content.

**How to apply:** When creating issues or discussions about docs, frame them around which persona is being served. Prioritize the three primary personas first.

## Discussion #4100 — doc structure rethink (2026-07-17)

Posted under Ideas: https://github.com/thunder-id/thunderid/discussions/4100

**Proposal (four pillars):**
1. **Quick Start** — touch the product fast
2. **Guides** — feature-oriented ("I know what I need"), each ending with a runnable sample (inline or separate project, but runnable)
3. **Use Cases** — problem-oriented ("I know my problem, show me the solution"), organized by problem domain not protocol name (e.g. "login on a device without a browser" not "CIBA"), linking into guides
4. **Reference** — API specs, config options, error codes, claim schemas (currently missing)

**Key decisions from the brainstorm:**
- Keep the name "Use Cases" (not "Solutions" — reads as marketing)
- Guides and use cases can share samples; cross-link both directions ("Related use cases" / "Related guides")
- Dropped the progressive/versioned samples idea (maintenance trap) from the proposal

**Open:** awaiting team feedback on #4100; Sahan shared it to the internal group for suggestions.

Related: [[thunderid-overview]]
