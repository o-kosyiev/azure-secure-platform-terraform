# Getting Started

## Local validation

```bash
terraform version
cp environments/dev.tfvars.example environments/dev.tfvars
./scripts/validate.sh
```

The test suite uses mocked providers and does not create cloud resources.

## First Azure plan

1. Create an Azure Storage backend protected with Azure RBAC.
2. Copy and edit `environments/backend.hcl.example`.
3. Replace the placeholder image digest in the environment file.
4. Authenticate with Azure CLI.
5. Run `./scripts/plan.sh dev`.
6. Review resource replacement, public access and role assignments before apply.

Never use a production backend while experimenting locally.
