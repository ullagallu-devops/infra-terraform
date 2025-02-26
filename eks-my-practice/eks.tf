# module "eks"{
#     depends_on = [module.eks_vpc]
#     source = "../modules/eks-practice"
#     environment = var.environemnt
#     project_name = var.project_name
#     vpc_id = module.eks_vpc.vpc_id
#     subnets = module.eks_vpc.public_subnet_ids
#     endpoint_private_access = false
#     endpoint_public_access = true
#     public_access_cidrs = ["0.0.0.0/0"]
# }