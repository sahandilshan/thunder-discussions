---
name: multi-agent-hierarchy
description: Discussion
metadata: 
  node_type: memory
  type: project
  originSessionId: 4843ffba-ed86-4a92-be01-6dfd741798fa
---

Discussion #3608: Multi-Agent Hierarchy and Connection Representation.

**Why:** Enterprises run multi-agent systems (orchestrators + sub-agents). ThunderID can represent individual agents but has no way to express agent-to-agent relationships, view hierarchies, or query "which agents belong to this system."

**Key distinction:** Runtime delegation chains (who-delegated-to-whom per request) are already handled by `act` claim nesting via token exchange (#3128). This discussion is about the **static identity relationship** — the registered, manageable representation in the agent entity model.

**Use cases:** Admin visibility of agent topology, scope ceiling propagation, blast radius containment on compromise, audit lineage, dynamic sub-agent registration.

**Open questions:**
1. Relationship model — parent-child field vs. edge table vs. agent groups
2. Depth — arbitrary vs. single level
3. Lifecycle coupling — cascade/orphan/block on parent deletion
4. Dynamic vs. static registration of sub-agents
5. Scope/permission inheritance
6. API/UX for viewing the hierarchy
7. Token representation beyond `act` claims

**How to apply:** This is the design forum for multi-agent representation. Decisions here feed into the agent entity model (#948) and interact with token resolution (#3128) and agent credentials (#3541).

Related: [[agent-identity-tokens]], [[agent-as-subject]], [[codebase-architecture]]
