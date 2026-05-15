---
name: session-protocol
description: How each chat session should auto-update shared memory before ending
metadata: 
  node_type: memory
  type: feedback
  originSessionId: bed1d0e5-f06f-4da6-9373-8f7a77263f1f
---

Every chat session must auto-update memory with decisions, action items, and open questions before ending.

**Why:** Sahand works across multiple chat sessions and tools (Claude Desktop + Claude Code). Each session needs to leave breadcrumbs for the next one so context is never lost.

**How to apply:** At the end of each session (or when significant decisions are made mid-session), persist to memory:
1. Decisions made — what was agreed on
2. Action items — issue/discussion numbers created, tasks assigned
3. Open questions — unresolved topics for future sessions
4. Any shifts in project direction or priorities

Link new memories to existing ones with [[name]] references. Update MEMORY.md index accordingly.
