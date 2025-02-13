module "bastion" {
  depends_on     = [module.instana_vpc]
  source         = "../../modules/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.bastion_sg_name
  vpc_id         = module.instana_vpc.vpc_id
  sg_description = var.bastion_sg_description
  common_tags    = var.bastion_common_tags
}
module "vpn" {
  depends_on     = [module.instana_vpc]
  source         = "../../modules/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.vpn_sg_name
  vpc_id         = module.instana_vpc.vpc_id
  sg_description = var.vpn_sg_description
  common_tags    = var.vpn_common_tags
}

module "mongo" {
  depends_on     = [module.instana_vpc]
  source         = "../../modules/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.mongo_sg_name
  vpc_id         = module.instana_vpc.vpc_id
  sg_description = var.mongo_sg_description
  common_tags    = var.mongo_common_tags
}

module "mysql" {
  depends_on     = [module.instana_vpc]
  source         = "../../modules/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.mysql_sg_name
  vpc_id         = module.instana_vpc.vpc_id
  sg_description = var.mysql_sg_description
  common_tags    = var.mysql_common_tags
}

module "redis" {
  depends_on     = [module.instana_vpc]
  source         = "../../modules/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.redis_sg_name
  vpc_id         = module.instana_vpc.vpc_id
  sg_description = var.redis_sg_description
  common_tags    = var.redis_common_tags
}

module "rabbitmq" {
  depends_on     = [module.instana_vpc]
  source         = "../../modules/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.rabbitmq_sg_name
  vpc_id         = module.instana_vpc.vpc_id
  sg_description = var.rabbitmq_sg_description
  common_tags    = var.rabbitmq_common_tags
}

module "catalogue" {
  depends_on     = [module.instana_vpc]
  source         = "../../modules/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.catalogue_sg_name
  vpc_id         = module.instana_vpc.vpc_id
  sg_description = var.catalogue_sg_description
  common_tags    = var.catalogue_common_tags
}

module "cart" {
  depends_on     = [module.instana_vpc]
  source         = "../../modules/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.cart_sg_name
  vpc_id         = module.instana_vpc.vpc_id
  sg_description = var.cart_sg_description
  common_tags    = var.cart_common_tags
}

module "user" {
  depends_on     = [module.instana_vpc]
  source         = "../../modules/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.user_sg_name
  vpc_id         = module.instana_vpc.vpc_id
  sg_description = var.user_sg_description
  common_tags    = var.user_common_tags
}

module "shipping" {
  depends_on     = [module.instana_vpc]
  source         = "../../modules/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.shipping_sg_name
  vpc_id         = module.instana_vpc.vpc_id
  sg_description = var.shipping_sg_description
  common_tags    = var.shipping_common_tags
}

module "payment" {
  depends_on     = [module.instana_vpc]
  source         = "../../modules/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.payment_sg_name
  vpc_id         = module.instana_vpc.vpc_id
  sg_description = var.payment_sg_description
  common_tags    = var.payment_common_tags
}

module "frontend" {
  depends_on     = [module.instana_vpc]
  source         = "../../modules/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.frontend_sg_name
  vpc_id         = module.instana_vpc.vpc_id
  sg_description = var.frontend_sg_description
  common_tags    = var.frontend_common_tags
}
module "alb" {
  depends_on     = [module.instana_vpc]
  source         = "../../modules/sg"
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = var.alb_sg_name
  vpc_id         = module.instana_vpc.vpc_id
  sg_description = var.alb_sg_description
  common_tags    = var.alb_common_tags
}

# mongo rules
resource "aws_security_group_rule" "catalogue_mongo" {
  description              = "This rule allows traffic from catalogue on port 27017"
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = module.catalogue.sg_id
  security_group_id        = module.mongo.sg_id
}
resource "aws_security_group_rule" "user_mongo" {
  description              = "This rule allows traffic from user on port 27017"
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id        = module.mongo.sg_id
}

# mysql rules
resource "aws_security_group_rule" "shipping_mysql" {
  description              = "This rule allows traffic from shipping on port 3306"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.shipping.sg_id
  security_group_id        = module.mysql.sg_id
}

# redis rules
resource "aws_security_group_rule" "user_redis" {
  description              = "This rule allows traffic from user on port 6379"
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = module.user.sg_id
  security_group_id        = module.redis.sg_id
}

resource "aws_security_group_rule" "cart_redis" {
  description              = "This rule allows traffic from cart on port 6379"
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = module.cart.sg_id
  security_group_id        = module.redis.sg_id
}

# rabbitmq rules
resource "aws_security_group_rule" "payment_rabbitmq" {
  description              = "This rule allows traffic from payment on port 5672"
  type                     = "ingress"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id        = module.rabbitmq.sg_id
}

# catalogue rules
resource "aws_security_group_rule" "frontend_catalogue" {
  description              = "This rule allows traffic from frontend on port 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id        = module.catalogue.sg_id
}

resource "aws_security_group_rule" "cart_catalogue" {
  description              = "This rule allows traffic from cart on port 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.cart.sg_id
  security_group_id        = module.catalogue.sg_id
}

# user rules
resource "aws_security_group_rule" "frontend_user" {
  description              = "This rule allows traffic from frontend on port 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id        = module.user.sg_id
}

resource "aws_security_group_rule" "payment_user" {
  description              = "This rule allows traffic from payment on port 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id        = module.user.sg_id
}

# cart rules
resource "aws_security_group_rule" "frontend_cart" {
  description              = "This rule allows traffic from frontend on port 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "payment_cart" {
  description              = "This rule allows traffic from payment on port 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.payment.sg_id
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "shipping_cart" {
  description              = "This rule allows traffic from shipping on port 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.shipping.sg_id
  security_group_id        = module.cart.sg_id
}

# shipping rules
resource "aws_security_group_rule" "frontend_shipping" {
  description              = "This rule allows traffic from frontend on port 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id        = module.shipping.sg_id
}

# payment rules
resource "aws_security_group_rule" "frontend_payment" {
  description              = "This rule allows traffic from frontend on port 8080"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id        = module.payment.sg_id
}

# frontend rules
resource "aws_security_group_rule" "alb_frontend" {
  description              = "This rule allows traffic from ALB on port 80"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.alb.sg_id
  security_group_id        = module.frontend.sg_id
}

# ALB Rules

resource "aws_security_group_rule" "http_alb" {
  description              = "This rule allows traffic from http on port 80"
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id        = module.alb.sg_id
}
resource "aws_security_group_rule" "https_alb" {
  description              = "This rule allows traffic from http on port 443"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id        = module.alb.sg_id
}

# Bastion Rules
resource "aws_security_group_rule" "ssh_bastion" {
  description              = "This rule allows traffic from ssh on port 22"
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id        = module.bastion.sg_id
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


