#!/usr/bin/env bash
set -Eeuo pipefail

repository_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
environment="${1:-dev}"
backend_file="${BACKEND_CONFIG_FILE:-$repository_root/environments/backend.hcl}"
variable_file="${TFVARS_FILE:-$repository_root/environments/${environment}.tfvars}"

for required_file in "$backend_file" "$variable_file"; do
  if [[ ! -f "$required_file" ]]; then
    printf 'Required configuration does not exist: %s\n' "$required_file" >&2
    exit 1
  fi
done

cd "$repository_root"
terraform init -input=false -backend-config="$backend_file"
terraform plan -input=false -lock-timeout=5m -var-file="$variable_file" -out="tfplan-${environment}"
