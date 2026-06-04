---
name: agent-identity-tokens
description: Discussion
metadata: 
  node_type: memory
  type: project
  originSessionId: cf6fe454-8f03-4b0e-9236-61ee4b6c9c9f
---

Discussion #3128: Agent identity resolution in M2M and OBO token flows.

**Why:** Three gaps in how agent identity surfaces in tokens:
1. M2M token `sub` = OAuth Client ID, not agent entity ID — resource servers can't identify the agent
2. Agents can't authenticate to other OAuth apps as a user (`AllowedUserTypes` excludes agent types)
3. OBO token `act.sub` = OAuth Client ID, not agent entity ID — delegation chain doesn't reflect real agent identity

**Decision (2026-06-04):** M2M token `sub` will be the **resource entity ID** (agent ID for agents, app ID for applications), not the OAuth client ID. Issue #3131 created.

**Revised OBO story (2026-06-04):** Token exchange `act.sub` problem is solved by #3131. New proposal: when a user logs in through an agent's OAuth client (authz code flow), the token should **automatically** include `act: { sub: "<agent-id>" }` — implicit OBO, no token exchange ceremony needed. Open question: default vs opt-in.

**How to apply:** Point 1 is decided (#3131). Point 3 is reframed as implicit OBO via authz code flow. Point 2 (agent auth to other apps with multi-credential support) remains open, likely a separate discussion.

Related: [[oauth-as-flows-vision]], [[design-principles]]
