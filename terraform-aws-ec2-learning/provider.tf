provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Client      = var.client
      Group       = var.group
      Environment = var.environment
      Purpose     = "Learning"
      ManagedBy   = "Terraform"
    }
  }
}
