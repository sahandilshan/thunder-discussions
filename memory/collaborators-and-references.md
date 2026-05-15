---
name: collaborators-and-references
description: "Key collaborators, CODEOWNERS, tools, and external references for the Thunder project"
metadata: 
  node_type: memory
  type: reference
  originSessionId: bed1d0e5-f06f-4da6-9373-8f7a77263f1f
---

**Key collaborators (design discussions):**
- @thiva-k — participates in GitHub discussions and design reviews
- @shashimalcse — participates in GitHub discussions and design reviews

**CODEOWNERS (frontend):**
- @brionmario — Gate app, frontend packages
- @DonOmalVindula — Console app, frontend packages
- @jeradrutnam — frontend packages

**Development:**
- Platform: Thunder (Asgardeo/WSO2), local dev at `localhost:8090`
- Languages: Go (backend), React 18 + TypeScript + Vite (frontend), Python (scripting)
- Tooling: GitHub (issues, discussions, templates), pnpm monorepo (frontend), make (backend)

**Industry references for design decisions:**
- Okta, Auth0, Keycloak, Entra ID, AWS Cognito, GCP — cross-referenced for IAM patterns
- OTel vendor perf docs: Datadog, New Relic, Lightstep
- RFCs: OAuth 2.0, RFC 7591 (DCR), RFC 7636 (PKCE), RFC 7662 (Introspection), RFC 8693 (Token Exchange), RFC 8707 (Resource Indicators), RFC 9068, RFC 9126 (PAR), RFC 9396

**GitHub templates:** feature.yml, improvement.yml, bug.yml, doc-issue.yml, design.yaml (discussion). Always follow these when creating artifacts.

**CI/CD highlights:** 16 workflows including dependency guard, platform-specific validation (Windows, Postgres), docs deployment, PR label enforcement, release milestone reminders.
