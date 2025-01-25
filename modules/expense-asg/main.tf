# Locals
locals {
    name = "${var.environment}-${var.project_name}"
}
resource "aws_launch_template" "app" {
  name               = local.name
  image_id           = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids

  tag_specifications {
    resource_type = "instance"
    tags = merge({ Name = "${var.environment}-${var.project_name}" }, var.common_tags)
  }
}
resource "aws_lb_target_group" "app" {
  name     = local.name
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check_path
    healthy_threshold   = 2
    unhealthy_threshold = 5
    protocol            = var.protocol
    port                = var.port
    matcher             = "200"
  }
}
# Autoscaling Group
resource "aws_autoscaling_group" "app" {
  name                      = local.name
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = "ELB"
  desired_capacity          = var.desired_capacity
  target_group_arns = [aws_lb_target_group.test.arn]  
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
    triggers = ["launch_template"]
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
resource "aws_autoscaling_policy" "aap" {
  name                   = local.name
  autoscaling_group_name = aws_autoscaling_group.app.name
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = var.target_value
  }
}

# Listner
resource "aws_lb_listener_rule" "http" {
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




# Locals
locals {
    name = "${var.environment}-${var.project_name}"
}

# # Module Definition
# module "alb_asg_module" {
#   source = "./modules/alb_asg"

#   environment          = var.environment
#   project_name         = var.project_name
#   ami_id               = var.ami_id
#   instance_type        = var.instance_type
#   key_name             = var.key_name
#   vpc_security_group_ids = var.vpc_security_group_ids
#   vpc_id               = var.vpc_id
#   subnets              = var.subnets
#   port                 = var.port
#   protocol             = var.protocol
#   health_check_path    = "/health"
#   asg_max_size         = var.asg_max_size
#   asg_min_size         = var.asg_min_size
#   desired_capacity     = var.desired_capacity
#   health_check_grace_period = var.health_check_grace_period
#   common_tags          = var.common_tags
#   target_value         = var.target_value
#   host_header_value    = var.host_header_value
#   listener_arn         = var.listener_arn
# }

# # Module Code in ./modules/alb_asg

# variable "environment" {}
# variable "project_name" {}
# variable "ami_id" {}
# variable "instance_type" {}
# variable "key_name" {}
# variable "vpc_security_group_ids" {}
# variable "vpc_id" {}
# variable "subnets" {}
# variable "port" {}
# variable "protocol" {}
# variable "health_check_path" {}
# variable "asg_max_size" {}
# variable "asg_min_size" {}
# variable "desired_capacity" {}
# variable "health_check_grace_period" {}
# variable "common_tags" {}
# variable "target_value" {}
# variable "host_header_value" {}
# variable "listener_arn" {}

# resource "aws_launch_template" "app" {
#   name               = "${var.environment}-${var.project_name}"
#   image_id           = var.ami_id
#   instance_type      = var.instance_type
#   key_name           = var.key_name
#   vpc_security_group_ids = var.vpc_security_group_ids

#   tag_specifications {
#     resource_type = "instance"
#     tags = merge({ Name = "${var.environment}-${var.project_name}" }, var.common_tags)
#   }
# }

# resource "aws_lb_target_group" "app" {
#   name     = "${var.environment}-${var.project_name}"
#   port     = var.port
#   protocol = var.protocol
#   vpc_id   = var.vpc_id

#   health_check {
#     path                = var.health_check_path
#     healthy_threshold   = 2
#     unhealthy_threshold = 5
#     protocol            = var.protocol
#     port                = var.port
#     matcher             = "200"
#   }
# }

# resource "aws_autoscaling_group" "app" {
#   name                      = "${var.environment}-${var.project_name}"
#   max_size                  = var.asg_max_size
#   min_size                  = var.asg_min_size
#   desired_capacity          = var.desired_capacity
#   health_check_grace_period = var.health_check_grace_period
#   health_check_type         = "ELB"
#   target_group_arns         = [aws_lb_target_group.app.arn]
#   vpc_zone_identifier       = var.subnets

#   launch_template {
#     id      = aws_launch_template.app.id
#     version = "$Latest"
#   }

#   instance_refresh {
#     strategy = "Rolling"
#     preferences {
#       min_healthy_percentage = 50
#     }
#     triggers = ["launch_template"]
#   }

#   tag {
#     key                 = "Name"
#     value               = "${var.environment}-${var.project_name}"
#     propagate_at_launch = true
#   }
# }

# resource "aws_autoscaling_policy" "app" {
#   name                   = "${var.environment}-${var.project_name}"
#   autoscaling_group_name = aws_autoscaling_group.app.name
#   policy_type            = "TargetTrackingScaling"
#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageCPUUtilization"
#     }
#     target_value = var.target_value
#   }
# }

# resource "aws_lb_listener" "frontend" {
#   load_balancer_arn = aws_lb.front_end.arn
#   port              = "443"
#   protocol          = "TLS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.app.arn
#   }
# }

# resource "aws_lb_listener_rule" "backend" {
#   listener_arn = var.listener_arn
#   priority     = 100

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.app.arn
#   }

#   condition {
#     host_header {
#       values = var.host_header_value
#     }
#   }
# }
