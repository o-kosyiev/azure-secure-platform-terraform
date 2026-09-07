variable "name_prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "infrastructure_subnet_id" {
  type = string
}

variable "log_analytics_workspace_id" {
  type = string
}

variable "workload_identity_id" {
  type = string
}

variable "registry_server" {
  type = string
}

variable "container_image" {
  type = string
}

variable "allowed_ingress_cidrs" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}
