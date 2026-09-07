variable "project_name" {
  description = "Short workload identifier used in Azure resource names."
  type        = string
  default     = "atlas"

  validation {
    condition     = can(regex("^[a-z][a-z0-9]{2,10}$", var.project_name))
    error_message = "project_name must contain 3-11 lowercase alphanumeric characters and start with a letter."
  }
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "environment must be dev, stage, or prod."
  }
}

variable "location" {
  description = "Azure region used by the platform."
  type        = string
  default     = "northeurope"
}

variable "vnet_cidr" {
  description = "Address space for the workload virtual network."
  type        = string
  default     = "10.40.0.0/16"

  validation {
    condition     = can(cidrnetmask(var.vnet_cidr))
    error_message = "vnet_cidr must be valid CIDR notation."
  }
}

variable "container_image" {
  description = "Immutable OCI image reference, including a sha256 digest."
  type        = string

  validation {
    condition     = can(regex("^.+@sha256:[0-9a-f]{64}$", var.container_image))
    error_message = "container_image must be pinned to a full sha256 digest."
  }
}

variable "allowed_ingress_cidrs" {
  description = "CIDR ranges allowed to reach the public HTTPS endpoint. Empty means no explicit IP restriction."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for cidr in var.allowed_ingress_cidrs : can(cidrnetmask(cidr))])
    error_message = "Every ingress entry must use valid CIDR notation."
  }
}

variable "tags" {
  description = "Additional tags applied to all supported resources."
  type        = map(string)
  default     = {}
}
