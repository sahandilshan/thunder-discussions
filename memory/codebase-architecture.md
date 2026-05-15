---
name: codebase-architecture
description: "High-level ThunderID architecture — entity model, domain packages, databases, flow engine, OAuth capabilities"
metadata: 
  node_type: memory
  type: project
  originSessionId: bed1d0e5-f06f-4da6-9373-8f7a77263f1f
---

Go backend + React frontend monorepo. Single binary serving REST API + two React SPAs (`/gate`, `/console`).

## Entity Model

Unified entity abstraction — users, applications, and agents are all "entities" with category differentiation:
- **Entity** — base identity principal (id, category, type, state, ouId, attributes, credentials)
- **User** — human identity with custom schema-defined attributes per user type
- **Application** — OAuth/OIDC client with inbound config (auth/registration/recovery flows)
- **Agent** — service accounts/automation, similar to users
- **Group** — collection of entities + nested groups, hierarchical within OUs
- **OrganizationUnit (OU)** — organizational hierarchy container with theme/layout assignment
- **EntityType** — schema definition for entity categories (custom attributes, self-registration)
- **Role** — authorization role with permissions scoped to resource servers
- **Resource Server** — OAuth resource server with identifier + handle
- **Resource** — hierarchical API resource within a server, with actions/permissions
- **Identity Provider (IDP)** — federated auth (OAuth, OIDC, Google, GitHub)

## Three Databases

- **ConfigDB** — entity types, roles, themes, OAuth profiles, IDPs, flows, translations, resource servers, certificates
- **RuntimeDB** — auth codes, auth requests, flow context, WebAuthn sessions, attribute cache, PAR requests (all with TTL)
- **UserDB** — OUs, entities, groups, group members, entity identifiers

All tables include DEPLOYMENT_ID for multi-tenancy.

## OAuth2/OIDC Capabilities (already implemented)

**Grant types:** authorization_code, client_credentials, refresh_token, token_exchange (RFC 8693)
**Client auth:** client_secret_basic, client_secret_post, private_key_jwt, none
**Advanced:** PKCE (RFC 7636), PAR (RFC 9126), token introspection, DCR (RFC 7591), resource indicators (RFC 8707)
**OIDC:** discovery, userinfo, JWKS, standard scopes (openid, profile, email, phone, address, roles)

## Flow Engine — 25 Executor Types

Authentication/registration are JSON node graphs (START → PROMPT → TASK → DECISION → COMPLETE).

Key executors: BasicAuth, SMSOTP, MagicLink, Passkey, OAuth, OIDC, Google, GitHub, Identifying, AuthAssert, Provisioning, AttributeCollector, Authorization, PermissionValidator, OU, HTTPRequest, UserTypeResolver, Invite, Email, CredentialSetter, Consent, OUResolver, AttributeUniquenessValidator, SMS, FederatedAuthResolver

## Backend Domain Packages (backend/internal/)

Core: entity, user, group, ou, role, resource, application, inboundclient, entitytype
Auth: authn (passkey, otp, magiclink, oauth, oidc, google, github, assert, consent), authz, cert, authnprovider
OAuth: oauth2 (authz, token, granthandlers, tokenservice, introspect, userinfo, dcr, discovery, par, clientauth, pkce, scope, resourceindicators, jwks)
Flow: flow (core, executor, flowexec, flowmeta, mgt)
Design: design (theme, layout, resolve)
System: config, database, cache, cors, cryptolab, jose, http, kmprovider, log, middleware, observability, template, i18n, importer, export, healthcheck, mcp

## Frontend

- **Console** — admin SPA (React 18, Vite, Monaco Editor, XYFlow for flow visualization)
- **Gate** — login/registration SPA (React 18, Vite, Asgardeo SDK)
- **16 shared packages** — components, design, contexts, hooks, i18n, utils, types, configure-users, configure-agent-types, configure-organization-units, configure-translations, logger, test-utils, eslint-plugin, prettier-config, create

**Why this memory exists:** Future discussions about features, improvements, or architecture need quick reference to what exists and how it's structured, without re-exploring the codebase.

**How to apply:** Reference this when discussing new features (check if capability already exists), architecture changes (understand current structure), or issue creation (know domain boundaries).

Related: [[thunderid-overview]], [[rfc8707-resource-indicators]], [[auth-claims-jwt]]
