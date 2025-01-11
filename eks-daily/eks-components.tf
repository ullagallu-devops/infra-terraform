### VPC
module "vpc" {
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

module "eks" {
  depends_on           = [module.vpc]
  source               = "../modules/eks"
  environment          = var.environment
  project_name         = var.project_name
  cluster_version      = "1.30"
  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.vpc.public_subnet_ids
  allowed_public_cidrs = ["0.0.0.0/0"]
  add_ons = {
    vpc-cni                = "v1.19.0-eksbuild.1"
    kube-proxy             = "v1.30.6-eksbuild.3"
    coredns                = "v1.11.1-eksbuild.8"
    eks-pod-identity-agent = "v1.3.4-eksbuild.1"
  }
  eks-iam-access = {
    admin-user={
      principal_arn = "arn:aws:iam::522814728660:root"
      policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
      kubernetes_groups = []
    }
  }
  node_groups = {
    blue = {
      instance_types = ["t3a.medium"]
      capacity_type  = "ON_DEMAND"
      scaling_config = {
        desired_size = 1
        max_size     = 1
        min_size     = 1
      }
    }
  }
}

# SPOT
# ON_DEMAND