output "service_arn" {
  description = "ARN of the ECS service"
  value       = aws_ecs_service.this.arn
}

output "service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.this.name
}