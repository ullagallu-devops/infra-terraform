resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.environment}/${var.project_name}/vpc_id"
  type  = "String"
  value = module.expense-vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.environment}/${var.project_name}/public_subnet_ids"
  type  = "StringList"
  value = join(",", module.expense-vpc.public_subnet_id)
}
resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.environment}/${var.project_name}/private_subnet_ids"
  type  = "StringList"
  value = join(",", module.expense-vpc.private_subnet_id)
}
resource "aws_ssm_parameter" "db_subnet_ids" {
  name  = "/${var.environment}/${var.project_name}/db_subnet_ids"
  type  = "StringList"
  value = join(",", module.expense-vpc.db_subnet_id)
}
resource "aws_ssm_parameter" "db_subnet_group_name" {
  name  = "/${var.environment}/${var.project_name}/db_subnet_group_name"
  type  = "String"
  value = module.expense-vpc.db_subnet_group
}