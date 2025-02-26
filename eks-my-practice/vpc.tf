module "eks_vpc" {
  source = "../modules/vpc-advanced"
  vpc_cidr = "192.168.0.0/16"
  environment = var.environment
  project_name = var.project_name
  common_tags = {
    Terraform = true
    Developer = "siva"
  }
  azs = ["ap-south-1a", "ap-south-1b"]
  public_subnet_cidrs = ["192.168.1.0/24","192.168.2.0/24"]
  private_subnet_cidrs = ["192.168.3.0/24","192.168.4.0/24"]
  database_subnet_cidrs = ["192.168.5.0/24","192.168.6.0/24"]
  enable_kubernetes_k8s_tags = true
  nat_gateway_configuration = "none"
  enable_vpc_flow_logs = false
}
