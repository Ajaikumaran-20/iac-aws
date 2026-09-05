terraform {
  backend "s3" {
    bucket  = "playground-614939597046-ap-south-1-an"
    key     = "terraform/ec2/state.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
