---
name: gitlab_cicd_ai_integration
description: Instructions for AI-driven Merge Request (MR) reviews and Pipeline debugging in GitLab.
---

# GitLab CI/CD AI Integration

## Overview
This skill formalizes how the agent interacts with `git.epam.com` (GitLab) for CI/CD operations, MR reviews, and pipeline troubleshooting.

## Core Directives

1. **Pipeline Debugging:**
   If a pipeline fails, use GitLab CLI (`glab`) or GitLab API (via `run_command` with curl/jq) to fetch the failing job log.
   - Do NOT fetch the entire log if it is >1000 lines. Use `tail` or `grep` to extract the relevant error block.

2. **MR Review Process:**
   When asked to review an MR:
   - Fetch the MR diff.
   - Analyze against `AGENTS.md` rules and DevSecOps constraints.
   - DO NOT automatically merge. Output recommendations for the human reviewer.

3. **GitLab CLI (`glab`) Usage:**
   - Prefer using `glab` over raw `curl` when available.
   - Examples: `glab mr view`, `glab ci status`, `glab ci trace <job-id>`.

4. **Delegation:**
   Complex pipeline debugging should be delegated to the `GitLab CI/CD Operator` persona to maintain clean context in the main Supervisor agent.
