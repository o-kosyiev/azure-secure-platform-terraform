# Private Networking

The VNet uses separate delegated Container Apps and private endpoint subnets. Address prefixes are derived from the root CIDR so environments remain predictable.

| DNS zone | Service |
|---|---|
| `privatelink.vaultcore.azure.net` | Key Vault |
| `privatelink.azurecr.io` | Azure Container Registry |

Validate name resolution from the workload environment, not from a public workstation. A private endpoint without the matching DNS link usually produces confusing timeouts or requests to a public address.
