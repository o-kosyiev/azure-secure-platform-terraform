locals {
  name_prefix = "${var.project_name}-${var.environment}"
  common_tags = merge(
    {
      environment = var.environment
      managed_by  = "terraform"
      project     = var.project_name
      repository  = "azure-secure-platform-terraform"
    },
    var.tags
  )
}
