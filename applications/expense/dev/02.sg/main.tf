module "bastion" {
  source         = "../../../../modules/sg"
  environment    = var.environment
  project_name   = var.project_name
  sg_name        = "bastion"
  sg_description = "Security group for the expense project bastion"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
}
module "vpn" {
  source         = "../../../../modules/sg"
  environment    = var.environment
  project_name   = var.project_name
  sg_name        = "vpn"
  sg_description = "Security group for the expense project vpn"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
}
module "db" {
  source         = "../../../../modules/sg"
  environment    = var.environment
  project_name   = var.project_name
  sg_name        = "db"
  sg_description = "Security group for the expense project db"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
}
module "backend" {
  source         = "../../../../modules/sg"
  environment    = var.environment
  project_name   = var.project_name
  sg_name        = "backend"
  sg_description = "Security group for the expense project backend"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
}
module "frontend" {
  source         = "../../../../modules/sg"
  environment    = var.environment
  project_name   = var.project_name
  sg_name        = "frontend"
  sg_description = "Security group for the expense project frontend"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
}
module "external_lb" {
  source         = "../../../../modules/sg"
  environment    = var.environment
  project_name   = var.project_name
  sg_name        = "external_lb"
  sg_description = "Security group for the expense project external_lb"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
}
module "internal_lb" {
  source         = "../../../../modules/sg"
  environment    = var.environment
  project_name   = var.project_name
  sg_name        = "internal_lb"
  sg_description = "Security group for the expense project internal_lb"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  common_tags    = var.common_tags
}

# DB Rules
resource "aws_security_group_rule" "db_backend" {
  description              = "Allow MySQL from backend"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.backend.sg_id
  security_group_id        = module.db.sg_id
}

resource "aws_security_group_rule" "db_vpn" {
  description              = "Allow MySQL from vpn"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.db.sg_id
}

resource "aws_security_group_rule" "db_bastion" {
  description              = "Allow MySQL from bastion"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.db.sg_id
}
# Backend Rules
resource "aws_security_group_rule" "backend_internal_lb" {
  description              = "allow traffic from internal_lb"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.internal_lb.sg_id
  security_group_id        = module.backend.sg_id
}

resource "aws_security_group_rule" "backend_bastion" {
  description              = "allow traffic from bastion"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.backend.sg_id
}

resource "aws_security_group_rule" "backend_vpn" {
  description              = "allow traffic from vpn"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.backend.sg_id
}
# Internal ALB SG Rules
resource "aws_security_group_rule" "vpn_internal_alb" {
  description              = "allow traffic from vpn"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.internal_lb.sg_id
}
resource "aws_security_group_rule" "bastion_internal_alb" {
  description              = "allow traffic from vpn"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.internal_lb.sg_id
}
resource "aws_security_group_rule" "frontend_internal_alb" {
  description              = "allow traffic from vpn"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id        = module.internal_lb.sg_id
}
# Frontend SG Rules
resource "aws_security_group_rule" "frontend_external_lb" {
  description              = "allow traffic from external_lb"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.external_lb.sg_id
  security_group_id        = module.frontend.sg_id
}
resource "aws_security_group_rule" "frontend_bastion" {
  description              = "allow traffic from bastion"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.frontend.sg_id
}

resource "aws_security_group_rule" "frontend_vpn" {
  description              = "allow traffic from vpn"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.frontend.sg_id
}

# External LB SG Rules
resource "aws_security_group_rule" "external_lb_internet_http" {
  description       = "allow traffic from internet"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.external_lb.sg_id
}

resource "aws_security_group_rule" "external_lb_internet_https" {
  description       = "allow traffic from internet"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.external_lb.sg_id
}


# Bastion
resource "aws_security_group_rule" "bastion_internet" {
  description       = "Allow SSH from the internet"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

# VPN
resource "aws_security_group_rule" "vpn_ssh" {
  description       = "This rule allows all traffic from internet on 22"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "vpn_https" {
  description       = "This rule allows all traffic from internet on 443"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "vpn_et" {
  description       = "This rule allows all traffic from internet on 943"
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "vpn_udp" {
  description       = "This rule allows all traffic from internet on 1194"
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

