# CI/CD

```mermaid
sequenceDiagram
  participant Dev as Engineer
  participant GH as GitHub Actions
  participant Azure as Azure
  Dev->>GH: Pull request
  GH->>GH: fmt, validate, test, scan
  Dev->>GH: Merge reviewed commit
  Dev->>GH: Manual deploy request
  GH->>Azure: Exchange OIDC token
  GH->>Azure: Terraform plan
  GH-->>Dev: Plan artifact and summary
  Dev->>GH: Approve protected environment
  GH->>Azure: Apply reviewed plan
```

| Workflow | Trigger | Cloud access |
|---|---|---|
| `ci.yml` | Pull request and main push | None |
| `deploy.yml` | Manual dispatch | OIDC, environment scoped |

The apply job downloads the exact plan generated for the same commit. Concurrency prevents overlapping changes to one environment.
