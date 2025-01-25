variable "environment" {
  type        = string
  description = "The environment (e.g., dev, prod)."
}

variable "project_name" {
  type        = string
  description = "The project name."
}

variable "lb_type" {
  type        = string
  description = "The type of load balancer (e.g., application or network)."
}

variable "internal_external" {
  type        = bool
  description = "Whether the load balancer is internal or external."
}

variable "alb_security_group" {
  type        = list(string)
  description = "Security groups for the load balancer."
}

variable "alb_subnets" {
  type        = list(string)
  description = "Subnets for the load balancer."
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Whether to enable deletion protection."
}

variable "create_http_listener" {
  type        = bool
  default     = true
  description = "Whether to create the HTTP listener."
}

variable "create_https_listener" {
  type        = bool
  default     = true
  description = "Whether to create the HTTPS listener."
}

variable "certificate_arn" {
  type        = string
  default     = ""
  description = "The ARN of the SSL certificate for HTTPS."
}

variable "zone_id" {
  type        = string
  description = "Route53 Zone ID for the alias record."
}

variable "common_tags" {
  type        = map(string)
  default     = {}
  description = "Common tags for the resources."
}
variable "component" {
  type = string
  description = "Please enter component name"
}
