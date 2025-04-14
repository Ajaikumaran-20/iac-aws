module "security_group" {
  source = "../module"

  region      = var.region
  vpc_id      = var.vpc_id
  sg_name     = var.sg_name
  description = var.description
}