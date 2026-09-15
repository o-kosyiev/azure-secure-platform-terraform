---
name: git_sync_enforcer
description: Automating the mandatory Git pre-flight check defined in AGENTS.md.
---

# Git Sync Enforcer

This skill standardizes and automates the mandatory Git pre-flight check required before making any code modifications in the WD-40 workspace.

## 1. Autonomous Execution Principles
- The agent is EXPLICITLY AUTHORIZED to use the `run_command` tool to autonomously execute the Git sync sequence at the start of any task that involves modifying code.
- You do NOT need to ask the user for permission to perform these non-destructive Git sync operations.

## 2. The Standardized Sync Sequence
Whenever you are tasked with modifying code in `iaac`, `is`, or `insights_engine`, you MUST run the following sequence to ensure the local branch is fully synced with the remote, avoiding merge conflicts or working on outdated code.

Execute this script:
```bash
echo "Starting pre-flight Git sync..."
REPO_DIR=$(pwd)
echo "Current directory: $REPO_DIR"

git fetch origin
STATUS=$(git status -uno)

if echo "$STATUS" | grep -q "Your branch is behind"; then
    echo "Branch is behind origin. Syncing..."
    if ! git diff-index --quiet HEAD --; then
        echo "Stashing uncommitted changes..."
        git stash
        git pull --rebase
        git stash pop
    else
        git pull --rebase
    fi
else
    echo "Branch is up-to-date with origin."
fi
```

## 3. Enforcement
- Never skip this sequence when creating a plan to edit files.
- If `git pull --rebase` fails due to a conflict, immediately stop and alert the user with the conflict details. Do not attempt to force-push or blindly resolve complex merge conflicts without human guidance.
