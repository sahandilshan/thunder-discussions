---
name: ciba-implementation
description: "CIBA onboarding to ThunderID — issue #2739, design discussion #2740, revised hybrid implementation approach"
metadata: 
  node_type: memory
  type: project
  originSessionId: 9f812337-c650-4544-ac44-77e35e106537
---

CIBA (OpenID Connect Client-Initiated Backchannel Authentication) is being onboarded to ThunderID.

- **Feature Issue:** #2739
- **Design Discussion:** #2740 (revised implementation comment posted 2026-05-14)
- **Scope:** Poll mode only (ping/push deferred)
- **Notification channels:** SMS/Email (push notifications deferred)

**Architecture decisions (revised 2026-05-14):**

The original proposal (flow-based grant executor: `ClientValidator → IdentifyingExecutor → CIBAGrantExecutor`) was revised after verifying the architecture. Current grant handlers are procedural (`ValidateGrant` + `HandleGrant`), and the flow-based grant pattern doesn't exist yet.

**Hybrid approach decided:**
- **Procedural layer:** New `CIBAGrantHandler` + `/oauth2/bc-authorize` endpoint + token endpoint extension for polling
- **Internal system flow:** Notification + async user auth runs as a standard ThunderID flow, initiated programmatically via `flowExecService.InitiateFlow()` (same pattern OAuth authorize endpoint uses)
- **Flow graph:** `START → NotificationDispatch → Authentication → Authorization → AuthAssertion → END`
- **New flow type:** `FlowTypeCIBA` added to `flow/common/constants.go`
- **Internal flow only** — not exposed in Console flow builder UI initially

**Key finding:** The flow engine is HTTP-agnostic (`context.Context`, not `*http.Request`). Executors (SMS, Email, Auth, AuthAssertion) have zero HTTP dependencies. The OAuth authorize endpoint already calls `InitiateFlow()` programmatically — this is the proven pattern CIBA reuses.

**Execution phases:**
1. bc-authorize creates `auth_req_id` state, initiates flow, notification fires, flow pauses at Authentication node
2. User taps notification link → Gate resumes flow with `executionID` → auth + authz + assertion → writes approval to RuntimeDB
3. Client polls `/token` → CIBAGrantHandler reads `auth_req_id` state → returns tokens or `authorization_pending`

**Key context:** CIBA is also positioned as an enabler for ambient agent authentication (AI agents obtaining user approval without browser redirects).

**Why:** Sahan's task is to onboard CIBA. Hybrid approach is the pragmatic path — uses the flow engine for composability without waiting for the full "grants as pluggable flows" infrastructure.

**How to apply:** Reference this when discussing CIBA implementation details, related OAuth flow architecture, or agent authentication patterns.

Related: [[codebase-architecture]], [[oauth-as-flows-vision]], [[thunderid-overview]]
