module "eks"{
    depends_on = [module.eks_vpc]
    source = "../modules/eks-practice"
    environment = var.environment
    project_name = var.project_name
    subnets = module.eks_vpc.public_subnet_ids
    endpoint_private_access = false
    endpoint_public_access = true
    public_access_cidrs = ["0.0.0.0/0"]
    common_tags = {
    Terraform = true
    Developer = "siva"
    }
    vpc_id = module.eks_vpc.vpc_id

    node_groups = {
        blue = {
            instance_types = ["t3a.medium"]
            capacity_type = "SPOT"
            desired_size = 2
            max_size = 2
            min_size = 2
        }
    }

    addons = {
        metrics-server = "v0.7.2-eksbuild.1"
        vpc-cni = "v1.19.3-eksbuild.1"
    }
}











