variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ECS cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ECS cluster"
  type        = list(string)
}

variable "enable_logging" {
  description = "Enable container insights logging"
  type        = bool
  default     = true
}

variable "log_group_prefix" {
  description = "Prefix for the ECS CloudWatch Log Group"
  type        = string
  default     = "/ecs"
}
