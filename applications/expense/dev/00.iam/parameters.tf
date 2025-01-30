resource "aws_ssm_parameter" "aws_cw" {
  name  = "/${var.environment}/${var.project_name}/aws-cw--role"
  type  = "String"
  value = aws_iam_role.test_role.name
}