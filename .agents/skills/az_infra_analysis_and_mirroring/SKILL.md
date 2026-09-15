---
name: az_infra_analysis_and_mirroring
description: Safe querying of live Azure resources and generating parameterized Terraform code.
---

# Azure Infrastructure Analysis and Mirroring

This skill enables the agent to safely analyze live Azure resources and generate corresponding Terraform code ("mirroring") without risking state corruption.

## 1. Autonomous Execution Principles
- The agent is EXPLICITLY AUTHORIZED to use the `run_command` tool to autonomously execute read-only `az` commands (e.g., `az resource list`, `az resource show`, `az postgres flexible-server show`).
- You do NOT need to ask the user for permission to run these read-only commands.
- ALWAYS use JMESPath queries (`--query`) or pipe to `jq` to extract only the necessary fields. Never dump full resource JSON payloads into the context window, as this is expensive and slows down analysis.
  - Example: `az containerapp show -n <app-name> -g <rg-name> --query "properties.configuration.ingress.fqdn" -o tsv`

## 2. Terraform Mirroring Best Practices
When the user asks to "mirror" infrastructure in Terraform:
- **No Direct State Manipulation:** Do not use `terraform import` commands directly in the terminal to avoid corrupting the remote state without human review.
- **Use Import Blocks:** Generate Terraform `import {}` blocks (supported in Terraform 1.5+) in a separate file (e.g., `imports.tf`) so the user can review them and Terraform can generate the code if desired.
- **Strict Parameterization:** NEVER hardcode resource names, SKUs, IP ranges, or locations in the generated `.tf` files. All mirrored infrastructure must be parameterized using variables in `variables.tf` and corresponding values mapped into `envs/dev/dev.tfvars`.
- **Modularity:** Integrate new mirrored resources into existing modules (e.g., `networking`, `container_apps`) or create a new module following the existing directory structure.
- **Least Privilege Security:** When extracting IAM roles from the live environment, map them to Terraform carefully. Prefer Resource Group level assignments over Subscription level assignments. If you observe excessive permissions in the live environment, warn the user and suggest a least-privilege alternative in the Terraform code.
