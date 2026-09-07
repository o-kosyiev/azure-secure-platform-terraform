#!/usr/bin/env bash
set -Eeuo pipefail

repository_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repository_root"

terraform fmt -check -recursive
terraform init -backend=false -input=false
terraform validate
terraform test

if command -v tflint >/dev/null 2>&1; then
  tflint --init
  tflint --recursive
fi

if command -v trivy >/dev/null 2>&1; then
  trivy config --exit-code 1 --severity HIGH,CRITICAL .
fi
