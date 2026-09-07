# Testing

## Test pyramid

| Level | Tool | Purpose |
|---|---|---|
| Formatting | Terraform fmt | Canonical source format |
| Static validation | Terraform validate | Provider schema and references |
| Unit-style IaC | Terraform test with mocks | Variables, assertions and plan behavior |
| Lint | TFLint | Provider and maintainability checks |
| Misconfiguration | Trivy | High/critical IaC findings |
| Secret detection | Gitleaks | Current tree and Git history |

Run the deterministic local suite with `./scripts/validate.sh`. A live plan is an integration test and belongs in an isolated subscription.
