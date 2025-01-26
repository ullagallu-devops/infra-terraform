variable "environment" {}
variable "project_name" {}

variable "common_tags" {}

# Launch Template
variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "vpc_security_group_ids" {}

# TargetGroup
variable "port" {}
variable "health_check_path" {}
variable "vpc_id" {}

# ASG
variable "asg_max_size" {}
variable "asg_min_size" {}
variable "health_check_grace_period" {}
variable "desired_capacity" {}
variable "subnets" {}

# ASG Policy
variable "target_value" {}

# Listener
variable "listener_arn" {}
variable "component" {}
variable "zone_name"{}
