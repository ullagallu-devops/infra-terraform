module "instana_vpc" {
  source              = "../../modules/vpc"
  azs                 = var.azs
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  db_subnet_cidr      = var.db_subnet_cidr
  vpc_cidr            = var.vpc_cidr
  environment         = var.environment
  project_name        = var.project_name
  common_tags         = var.vpc_common_tags
  enable_nat          = var.enable_nat
  vpc_peering_enable  = var.vpc_peering_enable
}