# IAM × AI Intelligence — Taxonomy

The map every scout run and deep-dive operates against. Two domains, three vendor tiers, ten capability columns.

## Domains

| Domain | Definition |
|--------|-----------|
| **IAM for AI** | Securing agents, MCP, A2A, machine/workload identity, agent-to-agent auth, delegated authorization for agents, capability-scoped tokens for AI |
| **AI for IAM** | Using AI to improve IAM itself — natural-language policy, anomaly detection, intelligent provisioning, AI-assisted threat response, LLM-driven consent, IAM config copilots |

## Vendor Tiers

### Tier 1 — Enterprise IAM
Auth0/Okta · Microsoft Entra ID · Ping Identity · ForgeRock · AWS Cognito · GCP IAM · Keycloak

### Tier 2 — AI-native / Modern
Stytch · WorkOS · Descope · Clerk · Pangea · Crossmint · Arcjet · Anthropic (MCP) · Google (A2A) · Microsoft (agent identity)

### Tier 3 — Adjacent Infra
Kong · Apigee · SPIFFE/SPIRE · Istio · HashiCorp Vault · Infisical · IETF OAuth WG · OpenID Foundation · FIDO Alliance

## Capability Columns

| # | Capability | What we track |
|---|-----------|---------------|
| C1 | Agent identity model | First-class entity? service account? new primitive? |
| C2 | Agent authentication | client credentials, mTLS, DPoP, token binding |
| C3 | Agent authorization | scoping, delegation, consent, least-privilege |
| C4 | MCP support | server registration, client auth, DCR, CIMD |
| C5 | A2A protocols | agent-to-agent auth/protocols |
| C6 | Workload identity | SPIFFE, cloud workload identity federation |
| C7 | Token security for AI | short-lived, audience-restricted, capability-scoped |
| C8 | AI-powered admin | NL policy, intelligent provisioning, config copilots |
| C9 | AI threat detection | anomaly detection, AI-assisted response |
| C10 | Standards participation | IETF drafts, OpenID specs authored/implemented |

## Coverage Tracker

Legend: `—` not yet researched · `✓` researched & cited · `~` partial/in progress

| Vendor | C1 | C2 | C3 | C4 | C5 | C6 | C7 | C8 | C9 | C10 | Last verified |
|--------|----|----|----|----|----|----|----|----|----|-----|---------------|
| Auth0/Okta | — | — | — | — | — | — | — | — | — | — | never |
| Entra ID | — | — | — | — | — | — | — | — | — | — | never |
| Ping Identity | — | — | — | — | — | — | — | — | — | — | never |
| ForgeRock | — | — | — | — | — | — | — | — | — | — | never |
| AWS Cognito | — | — | — | — | — | — | — | — | — | — | never |
| GCP IAM | — | — | — | — | — | — | — | — | — | — | never |
| Keycloak | — | — | — | — | — | — | — | — | — | — | never |
| Stytch | — | — | — | — | — | — | — | — | — | — | never |
| WorkOS | — | — | — | — | — | — | — | — | — | — | never |
| Descope | — | — | — | — | — | — | — | — | — | — | never |
| Clerk | — | — | — | — | — | — | — | — | — | — | never |
| Pangea | — | — | — | — | — | — | — | — | — | — | never |
| Crossmint | — | — | — | — | — | — | — | — | — | — | never |
| Arcjet | — | — | — | — | — | — | — | — | — | — | never |
| Anthropic (MCP) | — | — | — | — | — | — | — | — | — | — | never |
| Google (A2A) | — | — | — | — | — | — | — | — | — | — | never |
| Microsoft (agent id) | — | — | — | — | — | — | — | — | — | — | never |
| Kong | — | — | — | — | — | — | — | — | — | — | never |
| Apigee | — | — | — | — | — | — | — | — | — | — | never |
| SPIFFE/SPIRE | — | — | — | — | — | — | — | — | — | — | never |
| Istio | — | — | — | — | — | — | — | — | — | — | never |
| Vault | — | — | — | — | — | — | — | — | — | — | never |
| Infisical | — | — | — | — | — | — | — | — | — | — | never |
| IETF OAuth WG | — | — | — | — | — | — | — | — | — | — | never |
| OpenID Foundation | — | — | — | — | — | — | — | — | — | — | never |
| FIDO Alliance | — | — | — | — | — | — | — | — | — | — | never |

## ThunderID Baseline (for the Layer 4 lens)

Known existing capabilities to cross-reference against (verify live via `gh` each deep-dive):
- First-class agent identity (umbrella #2165, #2013, #2169, #2170)
- MCP: securing servers/clients (#2966), MCP Client as OAuth app type (#2974), MCP Server as Resource Server template (#2973), CIMD (#2975), MCP admin tools (#3112)
- Composable flow engine (grants-as-flows vision)
- OAuth2/OIDC: auth code, client credentials, token exchange (RFC 8693), PKCE, PAR, DCR (RFC 7591), resource indicators (RFC 8707)
