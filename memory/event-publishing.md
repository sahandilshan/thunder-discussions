---
name: event-publishing
description: "Analytics/event system design — decided on OpenTelemetry SDK approach, not message queues"
metadata: 
  node_type: memory
  type: project
  originSessionId: bed1d0e5-f06f-4da6-9373-8f7a77263f1f
---

Explored an analytics/event system for Thunder. Evaluated listener patterns vs. message queues vs. OpenTelemetry.

**Decision:** OpenTelemetry for purely observability and analytics use cases (no application logic triggering). OTel SDK implemented directly in code (no YAML/separate collector process) using custom exporters.

**Why not message queues:** Premature given Thunder's current single-service architecture. Start with simpler patterns and design abstractions that allow future migration.

**OTel philosophy:** The SDK separates instrumentation from data management. Filtering at the collector level is preferred over SDK-level filtering by design, though custom span processors and samplers are available when needed.

**Status:** Design concluded, moving toward implementation.

**How to apply:** This is the agreed direction. Any analytics/observability discussion should build on this OTel-first approach. If application-logic-triggering events are needed later, that's a separate concern from observability.

Related: [[thunderid-overview]], [[design-principles]]
