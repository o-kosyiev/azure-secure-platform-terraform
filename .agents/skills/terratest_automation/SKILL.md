---
name: terratest_automation
description: Rules for generating and running Go-based Terratest suites for Terraform.
---

# Terratest Automation

## Overview
Static analysis (checkov/tfsec) is insufficient for production-grade IaC. All core Terraform modules MUST be covered by Terratest (Go) to ensure resources are actually provisioned and destroyed successfully in a sandbox environment.

## Core Directives

1. **Test Location:**
   Terratest Go files must be placed in `infra/test/` alongside the modules they test.

2. **Sandbox Execution Only:**
   Terratests MUST ONLY target sandbox/dev subscriptions. Never run Terratest against Staging or Production credentials.

3. **Writing Terratests:**
   - Use `github.com/gruntwork-io/terratest/modules/terraform`.
   - Tests must always use `defer terraform.Destroy(t, terraformOptions)`.
   - Tests must validate the actual cloud state (e.g., making an HTTP request to an Azure Container App to check if it's up).

4. **Execution Validation:**
   Before marking a Terraform task as "Complete", if testing is requested, run `go test -v -timeout 30m` and parse the output to ensure the infrastructure successfully provisions and tears down.
