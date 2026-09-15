---
name: iac_security_and_compliance_scanning
description: Mandatory security and compliance rules for Terraform code (DevSecOps)
---

# Infrastructure as Code (IaC) Security & Compliance Scanning

## Overview
As part of the DevSecOps strategy, **ALL** Terraform configurations must be scanned for security vulnerabilities, misconfigurations, and compliance violations **before** they can be applied or pushed.

## Core Directives

1. **Mandatory Scanning:**
   Before running `terraform apply`, you MUST run a security scan using `checkov` or `tfsec`.
   - If `checkov` is available: `checkov -d .`
   - If `tfsec` is available: `tfsec .`

2. **Zero High/Critical Rule:**
   You are NOT allowed to proceed with applying or proposing Terraform changes if the scan reports any `HIGH` or `CRITICAL` severity issues. 

3. **Autonomous Remediation:**
   If the scan fails, you must attempt to fix the Terraform code autonomously:
   - Read the scan output.
   - Modify the `.tf` files to address the misconfiguration (e.g., enable encryption at rest, restrict open ports, enforce TLS 1.2+).
   - Re-run the scan to verify the fix.

4. **Approval for Exceptions:**
   If a security warning is a false positive or an accepted risk for a PoC environment, you MUST NOT ignore it autonomously. Ask the user for explicit permission to add an inline suppression comment (e.g., `# checkov:skip=CKV_AZURE_...`).
