output "vpc_id" {
  value = module.expense_vpc.vpc_id
}
output "public_subnet_id" {
  value = module.expense_vpc.public_subnet_id
}
output "private_subnet_cidr" {
  value = module.expense_vpc.private_subnet_id
}
output "db_subnet_cidr" {
  value = module.expense_vpc.db_subnet_id
}
output "db_subnet_group_name" {
  value = module.expense_vpc.db_subnet_group
}