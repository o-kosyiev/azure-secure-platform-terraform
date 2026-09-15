---
name: secrets_management_guardrails
description: Strict guidelines for handling sensitive data, secrets, and credentials
---

# Secrets Management Guardrails

## Overview
Mishandling secrets (tokens, passwords, connection strings, PATs, private keys) is a critical security risk. This skill enforces strict boundaries on how agents interact with sensitive data.

## Core Directives

1. **NO Hardcoding:**
   NEVER write plain-text secrets into source code, Terraform files, GitHub Actions workflows, or scripts. 
   - Use Data sources (e.g., `azurerm_key_vault_secret`).
   - Use environment variables or CI/CD secret references (`${{ secrets.MY_SECRET }}`).

2. **Azure Key Vault & Databricks Secret Scopes:**
   - For Azure infrastructure, always provision and reference Azure Key Vaults.
   - For Databricks, use Secret Scopes (`dbutils.secrets.get()`) instead of embedding tokens.

3. **Console Output Sanitization:**
   If you must run a command that outputs a token or connection string (e.g., `az account get-access-token` or `terraform output`), DO NOT print the raw token in your response to the user. State that the operation succeeded without echoing the secret.

4. **.gitignore Verification:**
   Before creating `.env` files or local configuration files containing secrets for testing, verify that they are explicitly listed in the `.gitignore` file. If they are not, update the `.gitignore` first.
