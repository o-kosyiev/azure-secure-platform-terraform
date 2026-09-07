# Security

## Trust boundaries

```mermaid
flowchart LR
  Repo[Public source] --> Runner[Ephemeral runner]
  Runner -->|OIDC token| Entra[Microsoft Entra ID]
  Entra -->|Short-lived access| Azure[Azure control plane]
  Workload[Container workload] -->|Managed identity| Services[Key Vault and ACR]
  Internet -. blocked .-> Services
```

## Required controls

| Control | Requirement |
|---|---|
| Workflow permissions | Read-only by default; `id-token: write` only for deployment jobs |
| Federation subject | Restrict to repository and protected environment |
| Azure role | Custom or least-privilege deployment role |
| State | Encryption, versioning, RBAC and network restrictions |
| Images | Immutable digest and vulnerability scan before deployment |
| Secrets | Runtime retrieval from Key Vault; never Terraform outputs |

Security scanners reduce risk but do not replace threat modeling and review.
