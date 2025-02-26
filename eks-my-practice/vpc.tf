module "eks_vpc" {
  source                     = "../modules/vpc"
  vpc_cidr                   = "192.168.0.0/16"
  environment                = var.environment
  project_name               = var.project_name
  azs                        = ["ap-south-1a", "ap-south-1b"]
  public_subnet_cidrs        = ["192.168.1.0/24", "192.168.2.0/24"]
  private_subnet_cidrs       = ["192.168.11.0/24", "192.168.12.0/24"]
  database_subnet_cidrs      = ["192.168.21.0/24", "192.168.22.0/24"]
  nat_gateway_configuration  = "none"
  enable_vpc_flow_logs       = true
  enable_kubernetes_k8s_tags = true
  common_tags = {
    Author = "Sivaramakrishna"
    Terraform = true
    Project= var.project_name
    Environment= var.environment

  }
}
