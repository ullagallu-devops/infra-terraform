output "vpc_id"{
    value = module.eks_vpc.vpc_id
}
output "public_subnet_ids"{
    value = module.eks_vpc.public_subnet_ids
}
output "private_subnet_ids"{
    value = module.eks_vpc.private_subnet_ids
}
output "db_subnet_ids"{
    value = module.eks_vpc.db_subnet_ids
}
output "db_subnet_group"{
    value = module.eks_vpc.db_subnet_group
}