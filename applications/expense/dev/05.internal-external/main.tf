locals {
  internal_alb = "internal"
  external_alb = "external"
}

module "expense_acm_external" {
  source       = "../../../../modules/acm"
  environment  = var.environment
  project_name = var.project_name
  common_tags = {
    "Terraform"   = "true"
    "Author"      = "sivaramakrishna"
    "Environment" = "dev"
    "Project"     = "expense"
    "Component"   = "acm"
  }
  component = local.external_alb
  zone_id   = var.zone_id
  zone_name = "bapatlas.site"

}
module "expense_internal" {
  source = "../../../../modules/alb"
  common_tags = {
    "Terraform"   = "true"
    "Author"      = "sivaramakrishna"
    "Environment" = "dev"
    "Project"     = "expense"
    "Component"   = "internal"
  }
  environment                = var.environment
  project_name               = var.project_name
  internal_external          = true
  lb_type                    = "application"
  alb_security_group         = [data.aws_ssm_parameter.internal_lb_sg.value]
  alb_subnets                = split(",",data.aws_ssm_parameter.private_subnet_ids.value)
  enable_deletion_protection = false
  create_http_listener       = true
  create_https_listener      = false
  zone_id                    = var.zone_id
  component                  = local.internal_alb
}

module "expense_external" {
  depends_on = [module.expense_acm_external]
  source     = "../../../../modules/alb"
  common_tags = {
    "Terraform"   = "true"
    "Author"      = "sivaramakrishna"
    "Environment" = "dev"
    "Project"     = "expense"
    "Component"   = "external"
  }
  environment                = var.environment
  project_name               = var.project_name
  internal_external          = false
  lb_type                    = "application"
  alb_security_group         = [data.aws_ssm_parameter.external_lb_sg.value]
  alb_subnets                = split(",",data.aws_ssm_parameter.public_subnet_ids.value)
  enable_deletion_protection = false
  create_http_listener       = false
  create_https_listener      = true
  certificate_arn            = module.expense_acm_external.certificate_arn
  zone_id                    = var.zone_id
  component                  = local.external_alb
}
