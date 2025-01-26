variable "environment" {}
variable "project_name" {}
variable "instance_type"{}
# Launch Template
variable "key_name"{}
# ASG
variable "asg_max_size" {}
variable "asg_min_size" {}
variable "desired_capacity" {}
variable "health_check_grace_period" {}
# ASG Policy
variable "target_value" {}
variable "zone_name"{}
