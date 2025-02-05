### Common_variables
variable "environment" {}
variable "project_name" {}

### VPC variables
variable "azs" {}
variable "vpc_cidr" {}
variable "public_subnet_cidr" {}
variable "private_subnet_cidr" {}
variable "db_subnet_cidr" {}
variable "vpc_common_tags" {}
variable "enable_nat" {}
variable "vpc_peering_enable" {}

### SG variables
variable "bastion_sg_name" {}
variable "bastion_sg_description" {}
variable "bastion_common_tags" {}

variable "vpn_sg_name" {}
variable "vpn_sg_description" {}
variable "vpn_common_tags" {}

variable "backend_sg_name" {}
variable "backend_sg_description" {}
variable "backend_common_tags" {}

variable "db_sg_name" {}
variable "db_sg_description" {}
variable "db_common_tags" {}

variable "alb_sg_name" {}
variable "alb_sg_description" {}
variable "alb_common_tags" {}


