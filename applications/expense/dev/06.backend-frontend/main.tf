locals{
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}
module "backend_asg"{
    source = "../../../../modules/expense-asg"
    environment = var.environment
    project_name = var.project_name
    common_tags = {
    "Terraform"   = "true"
    "Author"      = "sivaramakrishna"
    "Environment" = "dev"
    "Project"     = "expense"
    "Component"   = "backend-asg"
  }
  ami_id = data.aws_ami.backend.id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [data.aws_ssm_parameter.backend.value]
  health_check_grace_period = var.health_check_grace_period

  port = 8080
  health_check_path = "/health"
  vpc_id = local.vpc_id
  asg_max_size = var.asg_max_size
  asg_min_size = var.asg_min_size
  desired_capacity = var.desired_capacity
  subnets = data.aws_ssm_parameter.private_subnet_ids
  target_value = var.target_value

  listener_arn = data.aws_ssm_parameter.http_listner.value
  host_header_value = "internal"
  zone_name = var.zone_name
}