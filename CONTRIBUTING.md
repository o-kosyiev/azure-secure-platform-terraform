# Contributing

1. Create a focused branch from `main`.
2. Update tests and documentation with the code.
3. Run `./scripts/validate.sh`.
4. Open a pull request and include a sanitized Terraform plan summary when behavior changes.
5. Never commit state, plan artifacts, credentials, tenant data, or real environment configuration.

Module inputs should have descriptions, explicit types, secure defaults, and validation where practical. Breaking changes require a design decision entry in the Wiki.
