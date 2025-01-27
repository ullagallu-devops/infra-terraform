variable "family" {
  description = "Name of the task definition family"
  type        = string
}

variable "network_mode" {
  description = "Network mode for the task definition (e.g., awsvpc)"
  type        = string
  default     = "awsvpc"
}

variable "execution_role_arn" {
  description = "IAM role that allows the ECS agent to pull images and publish logs"
  type        = string
}

variable "task_role_arn" {
  description = "IAM role that containers in the task can assume"
  type        = string
  default     = null
}

variable "requires_compatibilities" {
  description = "Launch type compatibility (e.g., FARGATE)"
  type        = list(string)
}

variable "cpu" {
  description = "Task CPU value"
  type        = string
}

variable "memory" {
  description = "Task memory value"
  type        = string
}

variable "container_definitions" {
  description = "List of container definitions in JSON format"
  type        = any
}

variable "tags" {
  description = "Tags for the ECS task definition"
  type        = map(string)
  default     = {}
}
