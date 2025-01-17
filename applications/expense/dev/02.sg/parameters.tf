resource "aws_ssm_parameter" "bastion" {
  name  = "/${var.environment}/${var.project_name}/bastion-sg-id"
  type  = "String"
  value = module.bastion.sg_id
}
resource "aws_ssm_parameter" "vpn" {
  name  = "/${var.environment}/${var.project_name}/vpn-sg-id"
  type  = "String"
  value = module.vpn.sg_id
}
resource "aws_ssm_parameter" "db" {
  name  = "/${var.environment}/${var.project_name}/db-sg-id"
  type  = "String"
  value = module.db.sg_id
}
resource "aws_ssm_parameter" "backend" {
  name  = "/${var.environment}/${var.project_name}/backend-sg-id"
  type  = "String"
  value = module.backend.sg_id
}
resource "aws_ssm_parameter" "frontend" {
  name  = "/${var.environment}/${var.project_name}/frontend-sg-id"
  type  = "String"
  value = module.frontend.sg_id
}
resource "aws_ssm_parameter" "internal_lb" {
  name  = "/${var.environment}/${var.project_name}/internal-lb-sg-id"
  type  = "String"
  value = module.internal_lb.sg_id
}
resource "aws_ssm_parameter" "external_lb" {
  name  = "/${var.environment}/${var.project_name}/external-lb-sg-id"
  type  = "String"
  value = module.external_lb.sg_id
}