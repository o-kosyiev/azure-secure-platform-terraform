---
name: azure-terraform-best-practices
description: Best practices for using Azure CLI, GitHub CLI, and Terraform in IaC workflows.
---

# Azure & Terraform Best Practices

This skill outlines the core best practices for managing Azure infrastructure using Terraform and interacting with GitHub for CI/CD in this workspace.

## 1. Tool Usage Principles
- **Read-Only Automated Execution:** The agent may use `az` (Azure CLI) and `gh` (GitHub CLI) for querying state, listing resources, and validating configurations (e.g., `az resource list`, `gh issue list`).
- **User-Executed State Changes:** The agent MUST NOT automatically execute state-changing operations via `az` (like creating resources), `gh` (like merging PRs or pushing code), or `terraform` (like `terraform apply` or `destroy`).
- **Prompting the User:** For all state changes, the agent must formulate the exact command or plan, present it to the user, and ask the user to execute it in their own terminal and push the changes to GitHub.

## 2. Terraform Best Practices
- **Parameterization:** Hardcoding values is strictly forbidden. All variables (resource names, locations, tags, pricing tiers, IP ranges) must be parameterized using `variables.tf` and passed via `terraform.tfvars` or CI/CD pipelines.
- **Naming Conventions:** Use consistent naming modules or standard patterns (e.g., `<resource-type>-<project>-<env>-<region>`).
- **State Management:** Remote state must be securely configured (e.g., using Azure Storage Accounts with state locking enabled).
- **Least Privilege:** When generating Azure IAM roles and service principal configurations, adhere strictly to the principle of least privilege. Do not use `Owner` or `Contributor` on the subscription level unless absolutely necessary; scope permissions to the specific resource group.
- **Modularity:** Break down monolithic configurations into logically separated, reusable Terraform modules.

## 3. GitHub CLI and CI/CD
- Use the `gh` CLI to check workflow statuses (`gh run list`) and PR states (`gh pr view`).
- Infrastructure changes must be proposed via Pull Requests. The agent should assist in writing the Terraform code locally, and then instruct the user to:
  1. Commit the code (`git commit -m "feat: update infra"`)
  2. Push the branch (`git push origin <branch>`)
  3. Create a PR (`gh pr create`)
