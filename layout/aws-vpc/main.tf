module "vpc" {
  source             = "./module"
  region             = var.region
  cidr_block         = var.cidr_block
  vpc_name           = var.vpc_name
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
}