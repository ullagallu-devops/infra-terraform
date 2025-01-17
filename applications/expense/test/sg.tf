module "bastion" {
  depends_on     = [module.expense-vpc]
  source         = "../../../modules/sg"
  environment    = var.environment
  project_name   = var.project_name
  sg_name        = "bastion"
  sg_description = "Security group for the expense project bastion"
  vpc_id         = module.expense-vpc.vpc_id
  common_tags    = var.common_tags
}
module "vpn" {
  depends_on     = [module.expense-vpc]
  source         = "../../../modules/sg"
  environment    = var.environment
  project_name   = var.project_name
  sg_name        = "vpn"
  sg_description = "Security group for the expense project vpn"
  vpc_id         = module.expense-vpc.vpc_id
  common_tags    = var.common_tags
}
module "db" {
  depends_on     = [module.expense-vpc]
  source         = "../../../modules/sg"
  environment    = var.environment
  project_name   = var.project_name
  sg_name        = "db"
  sg_description = "Security group for the expense project db"
  vpc_id         = module.expense-vpc.vpc_id
  common_tags    = var.common_tags
}
module "backend" {
  depends_on     = [module.expense-vpc]
  source         = "../../../modules/sg"
  environment    = var.environment
  project_name   = var.project_name
  sg_name        = "backend"
  sg_description = "Security group for the expense project backend"
  vpc_id         = module.expense-vpc.vpc_id
  common_tags    = var.common_tags
}
module "frontend" {
  depends_on     = [module.expense-vpc]
  source         = "../../../modules/sg"
  environment    = var.environment
  project_name   = var.project_name
  sg_name        = "frontend"
  sg_description = "Security group for the expense project frontend"
  vpc_id         = module.expense-vpc.vpc_id
  common_tags    = var.common_tags
}
module "external_lb" {
  depends_on     = [module.expense-vpc]
  source         = "../../../modules/sg"
  environment    = var.environment
  project_name   = var.project_name
  sg_name        = "external_lb"
  sg_description = "Security group for the expense project external_lb"
  vpc_id         = module.expense-vpc.vpc_id
  common_tags    = var.common_tags
}
module "internal_lb" {
  depends_on     = [module.expense-vpc]
  source         = "../../../modules/sg"
  environment    = var.environment
  project_name   = var.project_name
  sg_name        = "internal_lb"
  sg_description = "Security group for the expense project internal_lb"
  vpc_id         = module.expense-vpc.vpc_id
  common_tags    = var.common_tags
}

# DB
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

# Backend
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

# Frontend
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

# Internal LB
resource "aws_security_group_rule" "frontend_internal_lb" {
  description              = "allow traffic from frontend"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id        = module.internal_lb.sg_id
}

resource "aws_security_group_rule" "internal_lb_vpn" {
  description              = "allow traffic from vpn"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.internal_lb.sg_id
}

# External LB
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