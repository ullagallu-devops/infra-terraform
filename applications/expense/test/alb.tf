locals {
  internal_alb = "internal"
  external_alb = "external"
}
module "internal_lb1" {
  depends_on                 = [module.expense_vpc, module.internal_lb]
  source                     = "../../../modules/alb"
  environment                = var.environment
  project_name               = var.project_name
  common_tags                = var.common_tags
  type                       = local.internal_alb
  alb_security_group         = [module.internal_lb.sg_id]
  internal                   = true
  alb_subnets                = module.expense_vpc.private_subnet_id
  enable_deletion_protection = false
  port                       = "80"
  protocol                   = "HTTP"
  content_type               = "text/html"
  message_body               = "<h1>Welcome to Internal Load Balancer</h1>"
  record_name                = local.internal_alb
  zone_id                    = var.zone_id
}


module "external_lb1" {
  source                     = "../../../modules/alb"
  environment                = var.environment
  project_name               = var.project_name
  common_tags                = var.common_tags
  type                       = local.external_alb
  alb_security_group         = [module.external_lb.sg_id]
  internal                   = false
  alb_subnets                = module.expense_vpc.public_subnet_id
  enable_deletion_protection = false
  port                       = "80"
  protocol                   = "HTTP"
  content_type               = "text/html"
  message_body               = "<h1>Welcome to External Load Balancer</h1>"
  record_name                = local.external_alb
  zone_id                    = var.zone_id
}
