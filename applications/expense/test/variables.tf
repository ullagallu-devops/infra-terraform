### Common variables
variable "environment" {}
variable "project_name" {}
variable "common_tags" {}
variable "zone_id" {}

### vpc variables
variable "azs" {}
variable "public_subnet_cidr" {}
variable "private_subnet_cidr" {}
variable "db_subnet_cidr" {}
variable "vpc_cidr" {}
variable "enable_nat" {}
variable "vpc_peering_enable" {}