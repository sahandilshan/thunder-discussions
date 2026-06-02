---
name: ciba-implementation
description: "CIBA onboarding to ThunderID — issue #2739, design discussion #2740, converged on Notification Dispatch utility flow + procedural orchestration (Option B)"
metadata:
  node_type: memory
  type: project
  originSessionId: 9f812337-c650-4544-ac44-77e35e106537
---

CIBA (OpenID Connect Client-Initiated Backchannel Authentication) is being onboarded to ThunderID.

- **Feature Issue:** #2739
- **Design Discussion:** #2740 (converged-approach comment posted 2026-05-15)
- **Scope:** Poll mode only (ping/push deferred); SMS/Email notification (push deferred); confidential clients only

## Converged design (2026-05-15) — supersedes earlier FlowTypeCIBA proposal

Team feedback (@ThaminduDilshan, @yudin-s, @senthalan) rejected bringing protocol specifics into the flow engine. Key principle: keep flow engine protocol-neutral with pre-processing → flow execution → post-processing layers (OAuth/CIBA logic in pre/post, native auth in the engine).

**What changed from the earlier note:**
- **NO `FlowTypeCIBA`.** CIBA authentication runs in a normal `AUTHENTICATION` flow — same human auth, just reached via a backchannel protocol.
- **Notification Dispatch = separate protocol-neutral UTILITY flow** (proposed flow category `UTILITY`). Pure "send a notification out of ThunderID," configurable: what notification + which delivery method(s). Reusable by any flow (magic link etc.); CIBA is just the first consumer. NOT a node baked into a CIBA flow.

**Two invocation options for wiring dispatch → auth:**
- **Option A (in-graph):** CIBA auth flow starts with a CALL node into the notification-dispatch utility flow. Uses the cross-flow CALL node from discussion **#2639** (still OPEN/unagreed — flow-type-category question, per-frame context split, phase-2 same-type/sub-flow fork all unresolved).
- **Option B (procedural) — CHOSEN for v1:** `/bc-authorize` grant handler invokes notification-dispatch via `InitiateFlow()` (same pattern the OAuth authorize endpoint already uses). No new engine capability, no dependency on #2639. Keeps protocol orchestration in the protocol layer.

**Why B:** Don't put CIBA on #2639's critical path. Utility flow is identical in both options — only invocation differs — so B→A migration later is cheap (swap procedural InitiateFlow for a CALL node in the flow definition; also unlocks in-graph reuse for any auth flow).

## Execution model (v1, poll, Option B)

Two flows start at TWO DIFFERENT TIMES:
1. **At `/bc-authorize`** (client waiting): validate client, resolve user from login_hint, create `auth_req_id` state in RuntimeDB {client_id, user_id, scope, binding_message, status:pending, expiry, interval}, `InitiateFlow(notification-dispatch)` (runs to completion synchronously, sends notification; **link carries auth_req_id, NOT executionId**), return auth_req_id + interval + expiry.
2. **At user tap** (their device, later): Gate resolves auth_req_id → app's authentication flow, `InitiateFlow(authentication-flow)` with context {auth_req_id, ...} → **executionId created here, auth_req_id↔executionId mapping stored here** → authenticate → authorization → auth_assert writes {status:approved, user, scopes} back into auth_req_id state.
3. **At `/token` poll:** CIBAGrantHandler reads auth_req_id state → pending/approved/denied/expired.

**Key:** `auth_req_id` is the durable anchor (created up front); `executionId` created lazily on tap. Auth flow is triggered by the user's tap, never by `/bc-authorize`. No parked auth execution that might be ignored.

**Key context:** CIBA also positioned as an enabler for ambient agent authentication (AI agents obtaining user approval without browser redirects) — see issue #2739.

**Why:** Sahan's task is to onboard CIBA. Option B is the pragmatic path — uses the flow engine's existing programmatic InitiateFlow for composability without waiting on the unresolved #2639 CALL node or the full "grants as pluggable flows" vision.

**How to apply:** Reference when discussing CIBA implementation, notification dispatch utility flow, the #2639 CALL node dependency, or agent authentication patterns.

Related: [[codebase-architecture]], [[oauth-as-flows-vision]], [[thunderid-overview]]
