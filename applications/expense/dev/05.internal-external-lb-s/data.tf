data "aws_ssm_parameter" "internal_lb" {
  name = "/${var.environment}/${var.project_name}/internal-lb-sg-id"
}
data "aws_ssm_parameter" "external_lb" {
  name = "/${var.environment}/${var.project_name}/external-lb-sg-id"
}
data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.environment}/${var.project_name}/private_subnet_ids"
}
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.environment}/${var.project_name}/public_subnet_ids"
}