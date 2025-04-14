module "vpc" {
  source = "../module/vpc"

  region             = var.region
  cidr_block         = var.cidr_block
  vpc_name           = var.vpc_name
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
}

module "sg" {
  source = "../module/sg"

}

module "asg" {
  source = "./module/asg"

  region        = var.region
  instance_type = var.instance_type
  subnets       = module.vpc.public_subnet_ids
  security_group_id = module.sg.security_group_id
  asg_name     = var.asg_name
}
