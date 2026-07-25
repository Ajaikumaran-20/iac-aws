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

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}