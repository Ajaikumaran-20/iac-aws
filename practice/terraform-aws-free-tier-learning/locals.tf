locals {
  name_prefix = "${var.client}-${var.group}-${var.environment}"
  www_fqdn    = var.domain_name
  app_url     = "https://${local.www_fqdn}"
  common_tags = {
    Client      = var.client
    Group       = var.group
    Environment = var.environment
    Purpose     = "Learning"
    ManagedBy   = "Terraform"
  }
}
