# Configuration

## Root inputs

| Variable | Default | Notes |
|---|---|---|
| `project_name` | `atlas` | Lowercase, 3–11 characters |
| `environment` | `dev` | `dev`, `stage`, or `prod` |
| `location` | `northeurope` | Confirm service availability first |
| `vnet_cidr` | `10.40.0.0/16` | Must not overlap connected networks |
| `container_image` | none | Full `sha256` digest is mandatory |
| `allowed_ingress_cidrs` | empty | Optional HTTPS source allowlist |
| `tags` | empty | Merged with mandatory governance tags |

## Configuration rules

- Keep real values in ignored `*.tfvars` files or a secured pipeline library.
- Use distinct address spaces and state keys per environment.
- Treat image digest changes as deployment changes requiring review.
- Do not put secrets in Terraform variables; applications retrieve them at runtime.
