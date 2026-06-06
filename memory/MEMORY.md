# Thunder Discussions Memory Index

## User & Workflow
- [User Profile](user-profile.md) — Sahan's role, expertise, IAM domain knowledge, working style
- [Challenge Ideas](feedback-challenge-ideas.md) — Provide counter-arguments, don't just agree
- [No Default CC](feedback-no-default-cc.md) — Don't assume who to CC; ask Sahan each time
- [Session Protocol](session-protocol.md) — Auto-update memory at end of every chat session

## Design Principles
- [Design Principles](design-principles.md) — Scope/claims separation, avoid over-engineering, OTel philosophy

## Active Work Streams
- [CIBA Implementation](ciba-implementation.md) — Issue #2739, Discussion #2740, poll mode, flow-based internal design
- [OAuth as Flows Vision](oauth-as-flows-vision.md) — Long-term plan: grants as pluggable flows, grant executor pattern
- [RFC 8707 Resource Indicators](rfc8707-resource-indicators.md) — Resource param → Resource Server, 3 open blockers
- [Auth Claims in JWT](auth-claims-jwt.md) — Issue #1931, roles/permissions in tokens, authorization_details
- [Event Publishing](event-publishing.md) — OTel SDK approach decided, moving to implementation
- [Security Review](security-review-wso2.md) — WSO2 issue #2805, items [c][d] still open
- [Agent Identity in Tokens](agent-identity-tokens.md) — Discussion #3128, M2M sub claim, OBO act claim, agent-to-app auth gaps
- [Claim Mapping IdP](claim-mapping-idp.md) — Discussion #3157, external→local claim mapping, precedence/transform/allowlist concerns

## Codebase & Architecture
- [Codebase Architecture](codebase-architecture.md) — Entity model, domain packages, databases, flow engine, OAuth capabilities
- [GitHub Project State](github-project-state.md) — Milestones, labels, 20 discussions, issue templates, release cadence

## Security
- [PII Logging Audit](pii-logging-audit.md) — Discussion #3103, 15 PII leakage instances in error-path logging

## Research
- [MCP IAM Vendor Research](mcp-iam-vendor-research.md) — How Auth0, Okta, Entra, Google, WorkOS, Descope etc. support MCP; ThunderID opportunities
- [Token Cleanup Discussion](token-cleanup-discussion.md) — Discussion #2781, vendor analysis on token purge strategies across 6 IAM platforms

## Planning
- [Documentation Plans](documentation-plans.md) — Persona-based doc structure proposed

## Project Context
- [ThunderID Overview](thunderid-overview.md) — Open-source OAuth2/IAM platform, Asgardeo/WSO2
- [Collaborators & References](collaborators-and-references.md) — CODEOWNERS, industry refs, GitHub templates; ask Sahan who to CC
