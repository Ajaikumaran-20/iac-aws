provider "aws" {
  region = var.aws_region

  assume_role {
    role_arn = var.terraform_role_arn
  }

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

  assume_role {
    role_arn = var.terraform_role_arn
  }

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
