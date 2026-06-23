---
name: feedback-no-auto-deep-research
description: NEVER run deep-research or multi-agent research workflows without explicit user approval — use daily scout results instead
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 923c1a79-9bd7-45ce-94ca-de7a00294f3a
---

In **interactive sessions**, never launch deep-research, multi-agent research workflows, or expensive fan-out searches automatically. Always ask Sahan first and get explicit approval before running them.

This does **not** apply to the daily automated scout routine (`trig_01UEpDdMSzQurXVAvP35ohLf`) — that should keep running deep research on its own as designed.

**Why:** A previous interactive session ran two deep research workflows without asking, which maxed out the session usage limit. Deep research is expensive and burns through token budgets fast. The daily scout runs on a separate cloud routine with its own budget, so it's fine.

**How to apply:**
1. **Daily scout (automated)**: Runs deep research automatically at 2 AM — no change, leave it alone.
2. **Interactive sessions**: When Sahan asks for a summary or research insights, **first** check the latest `intelligence/signals/` file from the daily scout — that's the default source.
3. Only suggest a live deep-research run if the scout data is insufficient or Sahan explicitly asks for one.
4. Before running any deep-research harness in an interactive session, state the cost/scope and wait for Sahan to confirm.
5. Never silently spawn multiple research agents — one unexpected deep-research is bad; two is unacceptable.

Related: [[iam-ai-intelligence-operation]]
