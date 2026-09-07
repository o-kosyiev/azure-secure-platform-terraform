# Remote State

Use one Azure Storage state key per environment and Azure AD authentication.

| Control | Recommendation |
|---|---|
| Authentication | OIDC in CI and Azure CLI locally |
| Authorization | Storage Blob Data Contributor on the state container only |
| Recovery | Blob versioning and soft delete |
| Network | Private endpoint or restricted trusted runner egress |
| Concurrency | Native blob lease plus workflow concurrency |

Never commit `backend.hcl`, state, plans, or state backups. State may contain values marked sensitive and must be handled as confidential data.
