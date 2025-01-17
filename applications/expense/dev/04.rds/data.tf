data "aws_ssm_parameter" "db_subnet_group" {
  name = "/${var.environment}/${var.project_name}/db_subnet_group_name"
}
data "aws_ssm_parameter" "db_sg_id" {
  name = "/${var.environment}/${var.project_name}/db-sg-id"
}