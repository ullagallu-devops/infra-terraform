### Common variables
variable "common_tags" {
  description = "Common tags for ALB"
  type        = map(any)
}
variable "environment" {
  description = "Environment name"
  type        = string
}
variable "project_name" {
  description = "Project name"
  type        = string
}

### ALB variables
variable "internal" {
  description = "Choose internal or external load balancer"
  type        = bool
}
variable "alb_security_group" {
  description = "Security group for ALB"
  type        = list(string)
}
variable "alb_subnets" {
    description = "Subnets for ALB"
    type        = list(string)
}
variable "enable_deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
}

variable "port" {
  description = "Port for the listener"
  type        = number
}

variable "protocol" {
  description = "Protocol for the listener (HTTP, HTTPS)"
  type        = string
}

variable "content_type" {}
variable "message_body" {}
variable "type" {}
variable "zone_id" {}
variable "record_name" {}



