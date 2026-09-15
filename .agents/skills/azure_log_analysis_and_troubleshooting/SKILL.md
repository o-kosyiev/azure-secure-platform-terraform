---
name: azure_log_analysis_and_troubleshooting
description: Standardizing log retrieval from Azure Container Apps (ACA) and Log Analytics.
---

# Azure Log Analysis and Troubleshooting

This skill empowers the agent to proactively retrieve and analyze logs from the Azure environment to diagnose and fix issues remotely.

## 1. Autonomous Execution Principles
- The agent is EXPLICITLY AUTHORIZED to use the `run_command` tool to autonomously execute non-destructive log retrieval commands.
- You do NOT need to ask the user for permission to read logs.
- Use `az monitor log-analytics query` for centralized logs and `az containerapp logs show` for specific ACA stream logs.

## 2. Log Retrieval Best Practices
- **Prevent Massive Context:** NEVER fetch unbounded logs. Always limit the time range (e.g., the last 1 to 4 hours) and filter by severity (`ERROR`, `FATAL`, `EXCEPTION`).
- **Efficient KQL Queries:** When using `az monitor log-analytics query`, use optimized Kusto Query Language (KQL) to filter out noise.
  - Example template:
    ```bash
    az monitor log-analytics query --workspace <workspace-id> --analytics-query "AppExceptions | where TimeGenerated > ago(1h) | project TimeGenerated, AppRoleName, ExceptionMessage, CorrelationId | order by TimeGenerated desc | limit 50"
    ```
- **ACA Logs:** Use the ACA CLI efficiently:
  - Example: `az containerapp logs show -n <app-name> -g <rg-name> --type console --tail 100`

## 3. Troubleshooting Matrix (WD-40 Environment)
When diagnosing issues in this specific environment, keep these known patterns in mind:
- **ACA Revision Failures:** Ensure that `PLACEHOLDER-REPLACE-ME` in the Langfuse secret isn't causing startup crashes. Check environment variables injected by CI/CD vs Terraform ignored lifecycle fields.
- **PostgreSQL Connectivity:** Check if the Container App is properly integrated into the VNet (delegated subnet). If the database throws authentication errors, verify the Entra ID configuration or if the password drifted.
- **Frontend/Backend Communication:** The frontend bypasses the Application Gateway for the production version, but backend apps use internal ingress. Look for failed HTTP requests and trace the `CorrelationId` between frontend logs and backend API logs.
