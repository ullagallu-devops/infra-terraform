# Common variables
variable "environment" {}
variable "project_name" {}
# VPC variables
variable "azs" {}
variable "public_subnet_cidr" {}
variable "private_subnet_cidr" {}
variable "db_subnet_cidr" {}
variable "vpc_cidr" {}
variable "vpc_common_tags" {}
variable "enable_nat" {}
variable "vpc_peering_enable" {}

# Sg varaible

variable "bastion_sg_name" {}
variable "bastion_sg_description" {}
variable "bastion_common_tags" {}

variable "vpn_sg_name" {}
variable "vpn_sg_description" {}
variable "vpn_common_tags" {}

variable "mongo_sg_name" {}
variable "mongo_sg_description" {}
variable "mongo_common_tags" {}

variable "mysql_sg_name" {}
variable "mysql_sg_description" {}
variable "mysql_common_tags" {}

variable "redis_sg_name" {}
variable "redis_sg_description" {}
variable "redis_common_tags" {}

variable "rabbitmq_sg_name" {}
variable "rabbitmq_sg_description" {}
variable "rabbitmq_common_tags" {}

variable "catalogue_sg_name" {}
variable "catalogue_sg_description" {}
variable "catalogue_common_tags" {}

variable "cart_sg_name" {}
variable "cart_sg_description" {}
variable "cart_common_tags" {}

variable "user_sg_name" {}
variable "user_sg_description" {}
variable "user_common_tags" {}

variable "shipping_sg_name" {}
variable "shipping_sg_description" {}
variable "shipping_common_tags" {}

variable "payment_sg_name" {}
variable "payment_sg_description" {}
variable "payment_common_tags" {}

variable "frontend_sg_name" {}
variable "frontend_sg_description" {}
variable "frontend_common_tags" {}

variable "alb_sg_name" {}
variable "alb_sg_description" {}
variable "alb_common_tags" {}