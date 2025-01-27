variable "name" {
  description = "Name of the ECS service"
  type        = string
}

variable "cluster_arn" {
  description = "ARN of the ECS cluster"
  type        = string
}

variable "task_definition" {
  description = "ARN of the ECS task definition"
  type        = string
}

variable "desired_count" {
  description = "The number of tasks to run for the service"
  type        = number
}

variable "launch_type" {
  description = "The launch type for the service (e.g., EC2, FARGATE)"
  type        = string
  default     = "FARGATE"
}

variable "deployment_controller_type" {
  description = "The deployment controller type (e.g., ECS, EXTERNAL)"
  type        = string
  default     = "ECS"
}

variable "subnets" {
  description = "List of subnets for the service"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security groups for the service"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to the service"
  type        = bool
  default     = false
}

variable "enable_ecs_managed_tags" {
  description = "Whether to enable ECS-managed tags for the service"
  type        = bool
  default     = false
}

variable "propagate_tags" {
  description = "Whether to propagate tags from task definitions or services"
  type        = string
  default     = "SERVICE"
}

variable "service_discovery_enabled" {
  description = "Whether to enable Service Discovery (Cloud Map) for the service"
  type        = bool
  default     = false
}

variable "service_discovery_arn" {
  description = "ARN of the Cloud Map service registry"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags for the ECS service"
  type        = map(string)
  default     = {}
}