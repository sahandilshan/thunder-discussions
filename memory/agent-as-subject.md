---
name: agent-as-subject
description: Discussion
metadata: 
  node_type: memory
  type: project
  originSessionId: 7897729d-22b3-430f-b84a-8428e87121dd
---

Discussion #3541: Agent as Subject — Credentials & Flow Compatibility.

**Why:** When an agent acts as a user principal (logging into an app like a human), two gaps exist:
1. **Credentials** — Agent schema has no support for subject credentials (username/password, OTP, certificates). Only client credentials exist today.
2. **Flow compatibility** — Human-designed auth flows include steps agents can't complete (passkeys, biometrics, CAPTCHA). No way to define agent-specific flows or flag flow compatibility.

**Open questions:**
1. What credential types should agents support as subjects?
2. How do subject credentials coexist with client credentials?
3. Should apps define separate auth flows for agents vs humans?

**Context:** @kavix expressed interest in contributing to #3506 (username/password piece). Sahan asked to finalize design first before implementation.

**How to apply:** This discussion is the design forum before any implementation on #3506. Credential and flow decisions here feed into #3491 (agent schema) and #3492 (agent registration UX).

Related: [[agent-identity-tokens]], [[oauth-as-flows-vision]], [[codebase-architecture]]
