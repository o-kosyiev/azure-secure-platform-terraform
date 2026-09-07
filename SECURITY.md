# Security Policy

## Supported branch

Security fixes are applied to `main`. This repository is a reference implementation and does not operate a hosted service.

## Reporting

Do not open a public issue for a suspected vulnerability. Use GitHub private vulnerability reporting when it is enabled for the repository.

Include the affected file, a minimal reproduction, potential impact, and a suggested mitigation. Never include live credentials, access tokens, private keys, state files, or organization identifiers.

## Security assumptions

- Azure authentication uses workload identity federation.
- Terraform state is stored remotely with Azure AD authorization and restricted network access.
- Deployments use environment protection rules and reviewed plans.
- Container images are referenced by digest.
- Production subscriptions, identities and state are separate from lower environments.

## Pre-publish checks

```bash
gitleaks detect --source . --redact
trivy config --severity HIGH,CRITICAL --exit-code 1 .
terraform test
```
