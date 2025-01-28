locals {
  name = "${var.environment}-${var.project_name}-${var.component}"
}

resource "aws_lb" "test" {
  name               = local.name
  internal           = var.internal_external
  load_balancer_type = var.lb_type
  security_groups    = var.alb_security_group
  subnets            = var.alb_subnets

  enable_deletion_protection = var.enable_deletion_protection
  tags = merge(
    {
      Name = local.name
    },
    var.common_tags
  )
}

resource "aws_lb_listener" "http" {
  count             = var.create_http_listener ? 1 : 0
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Fixed response content 80</h1>"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener" "https" {
  count             = var.create_https_listener ? 1 : 0
  load_balancer_arn = aws_lb.test.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Fixed response content 443</h1>"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "lb" {
  zone_id = var.zone_id
  name    = local.name
  type    = "A"

  alias {
    name                   = aws_lb.test.dns_name
    zone_id                = aws_lb.test.zone_id
    evaluate_target_health = true
  }
}
