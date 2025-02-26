variable "environment" {
  description = "Environment name"
  type        = string
}
variable "project_name" {
  description = "Project name"
  type        = string
}
variable "role_name" {
  description = "Role name"
  type        = string
}
variable "enable_service_role" {
  description = "Whether to create ECS service role"
  type        = bool
  default     = false
}
