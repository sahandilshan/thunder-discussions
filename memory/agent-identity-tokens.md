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

**How to apply:** When discussing agent token flows, reference this discussion. Point 2 (agent authentication to other apps with multi-credential support) may spin off into a separate discussion. The "internal resolution" approach (Thunder maps client ID → agent entity ID at token exchange time) is a key option being evaluated.

Related: [[oauth-as-flows-vision]], [[design-principles]]
