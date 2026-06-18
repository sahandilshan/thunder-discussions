---
name: spec-driven-development
description: Discussion
metadata: 
  node_type: memory
  type: project
  originSessionId: a679d3e1-3be1-4602-9246-b65ce232454c
---

Discussion #3292 ([Ideas] "Adopt Spec-Driven Development for ThunderID"), opened by brionmario 2026-06-12.

**Brion's proposal:** Add a `specs/` folder at repo root with living contracts: `SDK-SPECIFICATION.md` (canonical contract every SDK must implement) and `FEATURE-DEVELOPMENT-SPECIFICATION.md` (definition-of-done across server/SDKs/CLI/MCP/Skills/plugins/docs). Wire them into `.agent/skills/` so agents auto-load the right spec. Goal: AI generates conformant SDKs, every feature ships ecosystem-wide. Motivated by SDKs splitting to separate repos (#3051). Cites cal.com's specs/ folder as prior art.

**Our posted feedback** (comment #17279809) — narrowed to the two strongest points:
1. **Enforcement gap** — spec + skill are advisory; the only real forcing function is a CI check that fails the PR when the spec isn't met. Otherwise drift just moves somewhere prettier.
2. **Test vectors should be the source of truth, not prose** — markdown drifts from code; conformance test vectors are the real contract every SDK must pass, with markdown as human-readable companion. Also what makes "AI generates SDKs" safe.

**Other critiques we discussed but did NOT post** (kept comment short): "AI generates conformant SDKs" is oversold/risky for security-critical SDK code; the two specs are different animals (testable contract vs process checklist) and shouldn't be conflated; cross-repo spec governance/versioning unaddressed once SDKs split.

Relates to [[github-project-state]].
