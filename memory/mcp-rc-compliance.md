---
name: mcp-rc-compliance
description: MCP 2026-07-28 RC compliance tracker — Design discussion
metadata: 
  node_type: memory
  type: project
  originSessionId: 5a2027e2-b424-42ce-adf9-9260a9bde30e
---

Created 2026-07-08 to consolidate ThunderID's compliance work against the **MCP 2026-07-28 release candidate** (final July 28, 2026), whose headline change is that **RFC 7591 DCR is formally deprecated in favor of CIMD**.

**Artifacts (both cross-linked):**
- **Design discussion #3821** — `[Design Discussion] MCP Authorization Compliance — 2026-07-28 RC` (Design category). Home for design conversation: context, compliance-floor table, open questions.
- **Umbrella issue #3822** — `[Umbrella ☂️] MCP Authorization Compliance (2026-07-28 RC)` (Type/Task, Theme/AgentID). Implementation tracker with the work-item checklist.
- **#2219** left as-is (baseline for the *older* 2025-11-25 revision); two-way linked via a comment. Not superseded.

**Work items tracked (ranked):** (1) CIMD — highest, #2975/#3692; (2) DCR `application_type`/SEP-837 — #3664, scoped as bridge only since RC deprecates DCR; (3) first-class MCP client — #2974; (4) scope challenge/step-up (401 hint + 403 insufficient_scope) — no item yet; (5) customer MCP-server PRM enablement (RFC 9728 from Capabilities model + SDK) — no item yet.

**Terminology note for Sahan:** "umbrella" is NOT a discussion type — it's a title convention on a tracking *issue*. thunderid discussion categories are: Announcements, Design, General, Ideas, Polls, Q&A, Show and tell.

**Decisions made:** format = "Both" (Design discussion + umbrella issue, cross-linked); #2219 = leave as-is, link both ways. Two arguable points I flagged in the thread: #3664 hardens a mechanism the RC deprecates (bridge-only), and CIMD outranks the only currently-RC-scoped item (#3664).

Related: [[mcp-gap-analysis]] (the 2026-07-02 review that sourced the compliance-floor ranking), [[agent-identity-tokens]], [[resource-server-ux-rethink]]
