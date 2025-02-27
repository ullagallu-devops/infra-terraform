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
            max_size = 4
            min_size = 2
        }
    }
    eks-iam-access = {
        workstation = {
            principal_arn = "arn:aws:iam::522814728660:user/eks-siva.bapatlas.site"
            policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
            k8s_groups = []
            access_scope_type = "cluster"
        }
    }
}

module "eks_addons" {
    depends_on = [module.eks]
    source = "../modules/eks-addons"
    cluster_name = module.eks.cluster_name
    addons = {
        metrics-server = "v0.7.2-eksbuild.1"
        vpc-cni = "v1.19.3-eksbuild.1"
        coredns = "v1.11.4-eksbuild.2"
        kube-proxy = "v1.31.3-eksbuild.2"
        eks-pod-identity-agent = "v1.3.5-eksbuild.2"
    }
}











