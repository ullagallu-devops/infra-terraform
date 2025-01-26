resource "aws_ssm_parameter" "http_listner" {
  name  = "/${var.environment}/${var.project_name}/http-listner"
  type  = "StringList"
  value = join(",", module.expense_internal.http_listner)
}
resource "aws_ssm_parameter" "https_listner" {
  name  = "/${var.environment}/${var.project_name}/https-listner"
  type  = "StringList"
  value = join(",", module.expense_external.https_listner)
}