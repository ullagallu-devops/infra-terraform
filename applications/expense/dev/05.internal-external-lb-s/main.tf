locals {
  internal_alb = "internal"
  external_alb = "external"
}
module "internal_lb" {
  source                     = "../../../modules/alb"
  environment                = var.environment
  project_name               = var.project_name
  common_tags                = var.common_tags
  type                       = local.internal_alb
  alb_security_group         = [data.aws_ssm_parameter.internal_lb.value]
  internal                   = true
  alb_subnets                = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  enable_deletion_protection = false
  port                       = "80"
  protocol                   = "HTTP"
  content_type               = "text/html"
  message_body               = "<h1>Welcome to Internal Load Balancer</h1>"
  record_name                = local.internal_alb
  zone_id                    = var.zone_id
}


module "external_lb" {
  source                     = "../../../modules/alb"
  environment                = var.environment
  project_name               = var.project_name
  common_tags                = var.common_tags
  type                       = local.external_alb
  alb_security_group         = [data.aws_ssm_parameter.external_lb.value]
  internal                   = false
  alb_subnets                = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
  enable_deletion_protection = false
  port                       = "80"
  protocol                   = "HTTP"
  content_type               = "text/html"
  message_body               = "<h1>Welcome to External Load Balancer</h1>"
  record_name                = local.external_alb
  zone_id                    = var.zone_id
}
