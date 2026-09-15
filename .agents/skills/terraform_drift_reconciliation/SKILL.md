---
name: terraform_drift_reconciliation
description: Safely handling discrepancies between IaC code and live Azure environments.
---

# Terraform Drift Reconciliation

This skill guides the agent in safely handling discrepancies (drift) between the local `iaac` code and the live Azure environment without unintentionally undoing intentional external changes.

## 1. Autonomous Execution Principles
- The agent is EXPLICITLY AUTHORIZED to use the `run_command` tool to autonomously execute `terraform init`, `terraform validate`, and `terraform plan -var-file="envs/dev/dev.tfvars"`.
- You do NOT need to ask the user for permission to check for drift using `terraform plan`.
- **CRITICAL RESTRICTION:** You must NEVER run `terraform apply` or `terraform destroy` autonomously. This is strictly forbidden.

## 2. Intentional vs. Accidental Drift
The architecture contains known intentional drift which you must ignore and NOT attempt to reconcile:
- **ACA Lifecycle Ignore Rules:** The `container_apps` module ignores changes to images, environments, secrets, revision suffixes, and client-certificate-mode. Do not attempt to revert live ACA image tags back to Terraform's baseline.
- **Placeholder Secrets:** The Langfuse Entra client secret resource starts with `PLACEHOLDER-REPLACE-ME` and ignores subsequent changes. Do not try to update Terraform to hold the real secret.
- **Role Assignments:** Role assignments are managed externally (defined in the Access Matrix) and are not represented in Terraform. Do not attempt to add `azurerm_role_assignment` resources just because they exist in Azure, unless explicitly requested.

## 3. Drift Resolution Best Practices
- When actual, unintended drift is detected (e.g., someone manually changed an IP range or a SKU), you should:
  1. Identify exactly what drifted from the `terraform plan` output.
  2. Map the drift to the corresponding variable in `dev.tfvars` or the module configuration.
  3. Propose the exact code change to reconcile the drift, adhering to parameterization rules.
