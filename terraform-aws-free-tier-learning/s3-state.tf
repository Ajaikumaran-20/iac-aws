terraform {
  backend "s3" {
    bucket  = "playgroung-614939597046-ap-south-1-an"
    key     = "terraform/state.tfstate"   # path inside the bucket
    region  = "ap-south-1"
    encrypt = true
  }
}