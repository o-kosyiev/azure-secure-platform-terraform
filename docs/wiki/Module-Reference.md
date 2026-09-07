# Module Reference

| Module | Creates | Important outputs |
|---|---|---|
| `networking` | VNet, delegated subnets, NSGs, DNS zones and links | Subnet IDs, zone ID map |
| `observability` | Log Analytics and workspace-based Application Insights | Workspace ID |
| `key_vault` | Vault, private endpoint, diagnostics and reader role | Vault ID and URI |
| `registry` | Premium ACR, private endpoint and diagnostics | Registry ID and login server |
| `container_platform` | Container Apps environment and API app | App ID and FQDN |

Modules receive governance tags from the root. Cross-module RBAC remains visible in the root composition so reviewers can understand trust relationships without opening every module.
