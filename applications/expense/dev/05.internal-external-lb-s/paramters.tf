resource "aws_ssm_parameter" "internal_alb_arn" {
  name  = "/${var.environment}/${var.project_name}/internal-alb-arn"
  type  = "String"
  value = module.internal_lb.alb_arn
}
resource "aws_ssm_parameter" "internal_alb_listner_arn" {
  name  = "/${var.environment}/${var.project_name}/internal-alb-listner-arn"
  type  = "String"
  value = module.internal_lb.internal_listner
}

resource "aws_ssm_parameter" "external_alb_arn" {
  name  = "/${var.environment}/${var.project_name}/external-alb-arn"
  type  = "String"
  value = module.external_lb.alb_arn
}
resource "aws_ssm_parameter" "external_alb_listner_arn" {
  name  = "/${var.environment}/${var.project_name}/external-alb-listner-arn"
  type  = "String"
  value = module.external_lb.internal_listner
}