### VPC Module
module "vpc_module" {
  source              = "../../modules/vpc"
  azs                 = var.azs
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  db_subnet_cidr      = var.db_subnet_cidr
  environment         = var.environment
  project_name        = var.project_name
  common_tags         = var.vpc_common_tags
  enable_nat          = false
  vpc_peering_enable  = false
}

