locals{
  name = "${var.environment}-${var.project_name}-${var.type}"
}
resource "aws_lb" "test" {
  name               = local.name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.alb_security_group
  subnets            = var.alb_subnets

  enable_deletion_protection = var.enable_deletion_protection
  tags = merge(
    {
      Name = local.name
    },
    var.common_tags)
}

resource "aws_lb_listener" "listner" {
  load_balancer_arn = aws_lb.test.arn
  port              = var.port
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = var.content_type
      message_body = var.message_body
      status_code  = "200"
    }
  }
}


resource "aws_route53_record" "external" {
  zone_id = var.zone_id
  name    = "${var.environment}-${var.project_name}-${var.record_name}"
  type    = "A"

  alias {
    name                   = aws_lb.test.dns_name
    zone_id                = aws_lb.test.zone_id
    evaluate_target_health = true
  }
}

