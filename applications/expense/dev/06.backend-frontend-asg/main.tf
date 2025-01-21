locals {
  name = "${var.environment}-${var.project_name}"
}
module "backend_asg" {
  source = "../../../../modules/expense-asg"

  # Common 
  environment  = var.environment
  project_name = var.project_name
  common_tags  = var.common_tags
  # Launch Template
  protocol                  = "HTTP"
  ami_id                    = data.aws_ami.backend.id
  instance_type             = "t3.micro"
  key_name                  = "bapatlas.site"
  vpc_security_group_ids    = [data.aws_ssm_parameter.backend_sg.value]
  port                      = 8080
  vpc_id                    = data.aws_ssm_parameter.vpc_id.value
  asg_max_size              = 2
  asg_min_size              = 1
  health_check_grace_period = 90
  desired_capacity          = 1
  subnets                   = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  target_value              = 40
  listener_arn              = data.aws_ssm_parameter.internal_alb_listner_arn.value
  host_header_value         = ["${local.name}-internal.${var.zone_name}"]
}

