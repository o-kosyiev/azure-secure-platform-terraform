---
name: proactive_infrastructure_cicd_loop
description: End-to-end autonomous CI/CD debugging, diagnosis, and Terraform validation cycle using the gh CLI.
---

# Proactive Infrastructure CI/CD Loop

This skill enables the agent to operate in a closed-loop debugging cycle to rapidly iterate on infrastructure and CI/CD changes without constantly blocking on user input for mundane steps. It covers both **diagnosing failures** and **autonomously fixing them**.

## 1. Autonomous Execution Principles (The Feature Branch Exception)
While `AGENTS.md` strictly forbids automated `git push` operations, this skill introduces a strict, controlled exception for **feature branches**.
- The agent is EXPLICITLY AUTHORIZED to autonomously commit and `git push` changes ONLY to feature branches (e.g., `feat/*`, `fix/*`, `chore/*`, or a specific branch named by the user).
- **CRITICAL SECURITY RULE:** You MUST NEVER autonomously commit and push directly to `main`, `master`, or `develop`. If the user is currently on `develop` or `main`, you MUST create and checkout a new branch (e.g., `git checkout -b fix/terraform-issue`) before committing and pushing.

## 2. CI/CD Diagnosis (gh CLI)
The agent is EXPLICITLY AUTHORIZED to use `run_command` to autonomously execute non-destructive `gh` CLI commands to monitor and debug CI/CD runs across all repositories (`iaac`, `ai_briefing_assistant_prototype`, `insights_engine`). No user permission is needed for these commands:
- `gh run list --limit 5` — find recent failed runs.
- `gh run view <run-id>` — see individual step statuses.
- `gh run view <run-id> --log-failed` — fetch exact failure logs without downloading the full zip.

## 3. The Debugging Loop
When instructed to "fix the pipeline", "debug terraform", or operate proactively, follow this loop autonomously:

1. **Diagnose:** Use the `gh` commands from Section 2 to identify the root cause of the failure.
2. **Change:** Make targeted code/infrastructure changes locally to resolve the issue.
3. **Commit:** `git add .` and `git commit -m "fix: resolve <issue description>"`
4. **Push:** `git push -u origin HEAD` (ensuring you are on a feature branch).
5. **Trigger/Wait:**
   - If a PR is required to trigger the workflow, autonomously create a draft PR: `gh pr create --draft --title "Fix: ..." --body "Automated PR"`
   - If it's manual, trigger it: `gh workflow run <workflow-name> --ref <branch-name>`
6. **Monitor:** Autonomously run `gh run list --limit 1` to get the new Run ID, then use `gh run watch <run-id>` to wait for completion.
7. **Analyze:** If the pipeline fails, use `gh run view <run-id> --log-failed` to fetch the error, and immediately restart the loop from Step 1.
8. **Complete:** Once the pipeline succeeds (or if it requires a manual approval you cannot fulfill), stop and report success to the user with the final link to the PR or workflow run.

## 4. CI/CD Topology Knowledge
- **Terraform Pipeline (`iaac`):** Failures may occur in `init`, `validate`, `plan`, or `apply`. Pinpoint the exact step using `--log-failed`.
- **Container App Pipelines:** ACA updates use commit-SHA image tags and the frontend build receives `VITE_*` arguments. Trace whether the failure occurred during the build phase (e.g., missing build arg) or the deployment phase (e.g., Azure API error).
- **Reproducibility:** If you identify a fix (e.g., modifying `ci.yml` or a `Dockerfile`), verify the fix locally if possible (e.g., using `make test` or `npm run typecheck`) before committing.

## 5. Best Practices
- Always clean up temporary files (`tfplan`, etc.) before `git add .` to prevent accidentally committing sensitive state files.
- Keep commits small and iterative.
- **Secret Safety:** NEVER modify pipeline variables or secrets without explicit user consent. Do not print secret values into terminal logs.
- If you loop more than 3 times with failures, STOP and ask the user for guidance to avoid burning compute and CI minutes.
