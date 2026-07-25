# Main AWS provider
# GitHub Actions OIDC already authenticates as terraform-role
provider "aws" {
  region = "ap-south-1"

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

# US East 1 provider
# Required for resources that must be created in us-east-1,
# such as ACM certificates used by CloudFront
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"

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