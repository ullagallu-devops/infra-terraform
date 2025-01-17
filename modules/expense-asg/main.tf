# Locals
locals {
    name = "${var.environment}-${var.project_name}-${var.component}"
}
# Launch Template
resource "aws_launch_template" "test" {
  name = local.name
  image_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      {
        Name = local.name
      },
      var.common_tags)
    }
}

# TargetGroup
resource "aws_lb_target_group" "test" {
  name     = local.name
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id
  health_check {
    path                = "/health"
    protocol            = var.protocol
    port                = var.port
    interval            = var.interval
    timeout             = var.timeout 
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    matcher = var.mather
  }
}

# Autoscaling Group
resource "aws_placement_group" "test" {
  name     = "test"
  strategy = "cluster"
}

resource "aws_autoscaling_group" "bar" {
  name                      = local.name
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity  
  launch_template {
        id      = aws_launch_template.test.id
        version = "$Latest"
    }
  vpc_zone_identifier       = var.subnets

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["LaunchTemplate"]
  }

  tag {
    key                 = "Name"
    value               = local.name
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

  tag {
    key                 = "Project"
    value               = var.project_name
    propagate_at_launch = false
  }
}
# ASG policy
resource "aws_autoscaling_policy" "bat" {
  name                   = local.name
  autoscaling_group_name = aws_autoscaling_group.bar.name
  policy_type = var.policy_type
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = var.target_value
  }
}

# Listner
resource "aws_lb_listener_rule" "static" {
  listener_arn = var.listener_arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
  condition {
    host_header {
      values = var.host_header_value
    }
  }
}