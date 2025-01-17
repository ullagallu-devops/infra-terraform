variable "environment" {
  description = "Environment name"
  type        = string
}
variable "project_name" {
  description = "Project name"
  type        = string
}

variable "common_tags" {
  description = "Common tags for ALB"
  type        = map(any)
}
variable "component" {
  description = "Component name"
  type        = string
}

# Launch Template
variable "ami_id" {
    description = "AMI ID"
    type        = string
}
variable "instance_type" {
    description = "Instance type"
    type        = string
}
variable "key_name" {
    description = "Key name"
    type        = string
}
variable "vpc_security_group_ids" {
    description = "Security group IDs"
    type        = list(string)
}

# TargetGroup
variable "port" {
    description = "Port for the listener"
    type        = number
}
variable "protocol" {
    description = "Protocol for the listener (HTTP, HTTPS)"
    type        = string
}
variable "vpc_id" {
    description = "VPC ID"
    type        = string
}
variable "interval" {
    description = "Interval"
    type        = number
}
variable "timeout" {
    description = "Timeout"
    type        = number
}
variable "healthy_threshold" {
    description = "Healthy threshold"
    type        = number
}
variable "unhealthy_threshold" {
    description = "Unhealthy threshold"
    type        = number
}
variable "mather" {
    description = "Matcher"
    type        = string
}
# ASG
variable "asg_max_size" {
    description = "Max size"
    type        = number
}
variable "asg_min_size" {
    description = "Min size"
    type        = number
}
variable "health_check_grace_period" {
    description = "Health check grace period"
    type        = number
}
variable "health_check_type" {
    description = "Health check type"
    type        = string
}
variable "desired_capacity" {
    description = "Desired capacity"
    type        = number
}
variable "subnets" {
    description = "Subnets"
    type        = list(string)
}

# ASG Policy
variable "policy_type" {
    description = "Policy type"
    type        = string
}
variable "target_value" {
    description = "Target value"
    type        = number
}

# Listner
variable "listener_arn" {
    description = "Listener ARN"
    type        = string
}
variable "host_header_value" {
    description = "Host header"
    type        = list(string)
}