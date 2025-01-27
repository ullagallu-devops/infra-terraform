resource "aws_ecs_service" "this" {
  name            = var.name
  cluster         = var.cluster_arn
  task_definition = var.task_definition
  desired_count   = var.desired_count
  launch_type     = var.launch_type

  deployment_controller {
    type = var.deployment_controller_type
  }

  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  enable_ecs_managed_tags = var.enable_ecs_managed_tags
  propagate_tags          = var.propagate_tags

  tags = var.tags

  dynamic "service_registries" {
    for_each = var.service_discovery_enabled ? [1] : []
    content {
      registry_arn = var.service_discovery_arn
    }
  }
}
