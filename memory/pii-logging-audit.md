---
name: pii-logging-audit
description: Audit findings — 15 PII leakage instances in error-path logging across Go backend and TS SDKs
metadata: 
  node_type: memory
  type: project
  originSessionId: 6f7915d4-0e4b-4cb8-a4f3-9db3b7572ceb
---

Discussion #3103 created 2026-06-03: "PII Leakage in Error-Path Logging"

Found 15 instances where PII can leak into logs through error paths:
- **6 in Go backend**: raw HTTP response bodies from Vonage, Twilio, custom SMS, OAuth token/userinfo, GitHub email endpoints logged via `log.String("response", string(body))`
- **9 in TypeScript SDKs** (Nuxt, Next.js, Vue): raw error objects logged via `console.error` or `JSON.stringify(error)` in auth flows

Existing mitigations already in place: `log.MaskedString()` in Go, `maskSensitiveData` utility in frontend logger (unused in problem spots).

**Why:** Error-path-only logging makes this hard to catch in testing but dangerous in production — external provider responses (Twilio, GitHub, OAuth IdPs) can contain emails, phone numbers, tokens.

**How to apply:** Track discussion #3103 for team decision on sanitization strategy. SDK fixes likely higher priority than backend.
