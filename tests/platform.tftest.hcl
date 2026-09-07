mock_provider "azurerm" {
  override_data {
    target = data.azurerm_client_config.current
    values = {
      tenant_id = "00000000-0000-0000-0000-000000000000"
    }
  }
}
mock_provider "random" {
  override_resource {
    target = random_string.suffix
    values = {
      result = "a1b2c3"
    }
  }
}

variables {
  project_name    = "atlas"
  environment     = "dev"
  location        = "northeurope"
  container_image = "ghcr.io/example/portfolio-api@sha256:0000000000000000000000000000000000000000000000000000000000000000"
}

run "secure_defaults" {
  command = plan

  assert {
    condition     = azurerm_resource_group.platform.location == "northeurope"
    error_message = "The configured Azure region was not propagated."
  }

}

run "reject_mutable_image" {
  command = plan

  variables {
    container_image = "ghcr.io/example/portfolio-api:latest"
  }

  expect_failures = [var.container_image]
}
