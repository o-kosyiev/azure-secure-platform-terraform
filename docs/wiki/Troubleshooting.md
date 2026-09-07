# Troubleshooting

| Symptom | Likely cause | Check |
|---|---|---|
| ACR pull fails | Missing role or DNS path | Identity `AcrPull`, private DNS and network route |
| Key Vault returns 403 | RBAC propagation or wrong identity | Principal ID and role scope |
| Container App is unhealthy | Wrong port or image behavior | Revision logs and `/health` probe |
| Backend init fails | OIDC/backend authorization | Storage role, state key and federation subject |
| Plan wants replacement | Immutable property changed | Provider release notes and plan JSON |

Do not resolve incidents by making untracked portal changes. Capture an emergency change in Terraform immediately after stabilization.
