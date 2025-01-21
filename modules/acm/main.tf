locals {
  domain_name = "${var.environment}-${var.project_name}-${var.component}"
}
resource "aws_acm_certificate" "example" {
  domain_name       = local.domain_name
  validation_method = "DNS"

  tags = merge(
    {
      Name = local.domain_name
    },
    var.common_tags
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "example" {
  for_each = {
    for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 1
  type            = each.value.type
  zone_id         = var.zone_id
}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.example.arn
  validation_record_fqdns = [for record in aws_route53_record.example : record.fqdn]
}

variable "zone_id" {}
variable "environment" {}
variable "project_name" {}
variable "component" {}
variable "common_tags" {}