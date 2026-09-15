---
name: databricks_asset_bundles_and_unity_catalog
description: Guidelines for managing Databricks Asset Bundles (DABs) and Unity Catalog
---

# Databricks Asset Bundles (DABs) & Unity Catalog

## Overview
For Databricks Lakehouse projects, we standardize on Databricks Asset Bundles (DABs) for CI/CD and Unity Catalog (UC) for data governance.

## Core Directives

1. **Using Databricks Asset Bundles:**
   - All Databricks jobs, pipelines (DLT), and MLOps workflows must be defined using `databricks.yml`.
   - Avoid creating resources via the UI or raw API calls if they can be managed via DABs.
   - Use the `databricks bundle validate` and `databricks bundle deploy` commands for deployment.

2. **Environment Separation:**
   - Structure `databricks.yml` with clear targets: `dev`, `staging`, and `prod`.
   - The `dev` target should use developer-specific workspaces and `mode: development` for isolated testing.

3. **Unity Catalog Governance:**
   - All tables must be created within a Unity Catalog standard (3-level namespace: `catalog.schema.table`).
   - Permissions must be managed via Data Access Control (SQL `GRANT` statements or Terraform Unity Catalog resources), NEVER via legacy table ACLs.

4. **Service Principals:**
   - Automated deployments and CI/CD pipelines must authenticate using Azure Service Principals (or AWS/GCP equivalents). DO NOT use personal PATs for production deployments.
