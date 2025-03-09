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
            desired_size = 6
            max_size = 6
            min_size = 1
        }
    }
    eks-iam-access = {
        workstation = {
            principal_arn = "arn:aws:iam::522814728660:user/eks-siva.bapatlas.site"
            policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
            k8s_groups = []
            access_scope_type = "cluster"
        }
        runner = {
            principal_arn = "arn:aws:iam::522814728660:role/eks-role-github-actions-runner-bapatlas.site"
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

module "ebs_pod_identity" {
    depends_on = [module.eks,helm_release.ebs_csi_driver]
    source = "../modules/eks-pod-identity"

    environment = var.environment
    irsa_role_name = "ebs-pod-identity"
    managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"]
    cluster_name = module.eks.cluster_name
    namespace = "kube-system"
    service_account = "ebs-csi-controller-sa"
}
# Some times unable to provision volumes due to crendtial bound issue then simpley restart respected deployment that solves your problem
# kubectl rollout restart deployment ebs-csi-controller -n kube-system
# helm install aws-load-balancer-controller eks/aws-load-balancer-controller --set clusterName=dev-siva-cluster  --set region=ap-south-1  --set vpcId=vpc-02eb3fca8ea5f0dc1  -n kube-system --set serviceAccount.name=aws-load-balancer-controller

module "alb_ingress_controller" {
    depends_on = [module.eks,helm_release.ebs_csi_driver]
    source = "../modules/eks-pod-identity"

    environment = var.environment
    irsa_role_name = "alb_ingress_controller"
    managed_policy_arns = ["arn:aws:iam::522814728660:policy/AWSLoadBalancerControllerIAMPolicy"]
    cluster_name = module.eks.cluster_name
    namespace = "kube-system"
    service_account = "aws-load-balancer-controller"
}

module "external-dns" {
    depends_on = [module.eks]
    source = "../modules/eks-pod-identity"

    environment = var.environment
    irsa_role_name = "external-dns"
    managed_policy_arns = ["arn:aws:iam::522814728660:policy/AllowExternalDNSUpdates"]
    cluster_name = module.eks.cluster_name
    namespace = "kube-system"
    service_account = "external-dns"
}







