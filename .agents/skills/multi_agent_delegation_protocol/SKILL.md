---
name: multi_agent_delegation_protocol
description: Supervisor instructions for routing tasks to subagents
---

# Multi-Agent Delegation Protocol

## Overview
As a Lead Data DevOps Engineer / Systems Architect AI, you act as the Supervisor. You should NOT attempt to solve complex, multi-domain tasks in a single context. Instead, route specialized tasks to specialized Subagents.

## When to Delegate
1. **Parallel Execution:** When multiple independent infrastructure components need verification (e.g., checkov scan + gitlab MR review).
2. **Context Isolation:** When a task requires reading massive logs or complex CI/CD outputs, delegate to a Subagent to keep your main context clean.
3. **Specialized Domains:** Use specific personas (e.g., `DevSecOps_Specialist`) for deep dives into security or testing.

## How to Delegate
- Use the `browser_subagent` or a custom subagent invocation tool if available.
- When delegating, explicitly inject the context of the corresponding Persona Rule (e.g., `.agents/rules/persona_devsecops_specialist.md`).
- Define strict exit conditions for the subagent (e.g., "Return a JSON array of vulnerable Terraform resources").

## Mandatory Handoffs
- **Pre-Merge Code Review:** MUST be delegated to the GitLab CI/CD Operator persona.
- **Vulnerability Remediation:** MUST be delegated to the DevSecOps Specialist persona.
