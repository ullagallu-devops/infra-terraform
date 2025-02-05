module "bastion" {
  depends_on     = [module.vpc_module]
  source         = "../../modules/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.bastion_sg_name
  vpc_id         = module.vpc_module.vpc_id
  sg_description = var.bastion_sg_description
  common_tags    = var.bastion_common_tags
}
module "vpn" {
  depends_on     = [module.vpc_module]
  source         = "../../modules/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.vpn_sg_name
  vpc_id         = module.vpc_module.vpc_id
  sg_description = var.vpn_sg_description
  common_tags    = var.vpn_common_tags
}
module "backend" {
  depends_on     = [module.vpc_module]
  source         = "../../modules/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.backend_sg_name
  vpc_id         = module.vpc_module.vpc_id
  sg_description = var.backend_sg_description
  common_tags    = var.backend_common_tags
}

module "db" {
  depends_on     = [module.vpc_module]
  source         = "../../modules/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.db_sg_name
  vpc_id         = module.vpc_module.vpc_id
  sg_description = var.db_sg_description
  common_tags    = var.db_common_tags
}

module "alb" {
  depends_on     = [module.vpc_module]
  source         = "../../modules/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.alb_sg_name
  vpc_id         = module.vpc_module.vpc_id
  sg_description = var.alb_sg_description
  common_tags    = var.alb_common_tags
}

# DB Rules
resource "aws_security_group_rule" "vpn_db" {
  description              = "This rule allows traffic from vpn on port 3306"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.db.sg_id
}

resource "aws_security_group_rule" "bastion_db" {
  description              = "This rule allows traffic from bastion on port 3306"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.db.sg_id
}

resource "aws_security_group_rule" "backend_db" {
  description              = "This rule allows traffic from backend on port 3306"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.backend.sg_id
  security_group_id        = module.db.sg_id
}

# Backend Rules
resource "aws_security_group_rule" "alb_backend" {
  description              = "This rule allows traffic from ALB on port 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.alb.sg_id
  security_group_id        = module.backend.sg_id
}

resource "aws_security_group_rule" "bastion_backend" {
  description              = "This rule allows traffic from bastion on port 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.backend.sg_id
}

resource "aws_security_group_rule" "vpn_backend" {
  description              = "This rule allows traffic from vpn on port 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.backend.sg_id
}

# Bastion Rules
resource "aws_security_group_rule" "bastion_ssh" {
  description       = "This rule allows all traffic from internet on 22"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

# VPN Rules
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
  description       = "This rule allows all traffic from internet on 992"
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

# ALB Rules
resource "aws_security_group_rule" "vpn_alb" {
  description              = "This rule allows traffic from vpn on port 80"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.alb.sg_id
}

resource "aws_security_group_rule" "bastion_alb" {
  description              = "This rule allows traffic from bastion on port 80"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id        = module.alb.sg_id
}

resource "aws_security_group_rule" "http_internet" {
  description       = "Allow http from anywhere"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.alb.sg_id
}

resource "aws_security_group_rule" "https_internet" {
  description       = "Allow https from anywhere"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.alb.sg_id
}
