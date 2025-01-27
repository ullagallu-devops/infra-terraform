resource "aws_ecs_task_definition" "this" {
  family                   = var.family
  network_mode             = var.network_mode
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  requires_compatibilities = var.requires_compatibilities
  cpu                      = var.cpu
  memory                   = var.memory
  container_definitions    = jsonencode(var.container_definitions)

  tags = var.tags
}
