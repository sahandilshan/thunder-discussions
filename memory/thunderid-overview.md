---
name: thunderid-overview
description: "Core identity, architecture, and positioning of the ThunderID (Thunder) project"
metadata: 
  node_type: memory
  type: project
  originSessionId: bed1d0e5-f06f-4da6-9373-8f7a77263f1f
---

ThunderID (commonly called "Thunder") is an open-source OAuth2/IAM platform developed by Asgardeo (under WSO2). Designed for extensibility, scalability, and containerized/microservices deployment, targeting authentication across applications, services, and AI agents.

**Why:** The IAM space needs a developer-first, composable identity solution that treats AI agents and workloads as first-class citizens alongside human users.

**How to apply:** All discussions, issues, and feature proposals should align with these pillars — performance, composability, developer experience, and multi-entity identity (humans + agents + workloads). Currently a single-service architecture — avoid premature complexity.

**GitHub**: `thunder-id/thunderid` (main branch)
**Local dev**: `localhost:8090`
**Protocols**: OAuth 2.0, PKCE, RFC 8707, RFC 9068, RFC 9396, OpenTelemetry

Related: [[rfc8707-resource-indicators]], [[auth-claims-jwt]], [[event-publishing]], [[documentation-plans]]
