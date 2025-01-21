data "aws_ami" "backend" {
  owners      = ["self"]
  most_recent = true
  filter {
    name   = "name"
    values = ["backend-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
# data "aws_ami" "frontend" {
#   owners      = ["self"]
#   most_recent = true
#   filter {
#     name   = "name"
#     values = ["frontend-*"]
#   }

#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

data "aws_ssm_parameter" "backend_sg" {
  name = "/${var.environment}/${var.project_name}/backend-sg-id"
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.environment}/${var.project_name}/vpc_id"
}

data "aws_ssm_parameter" "internal_lb_sg" {
  name = "/${var.environment}/${var.project_name}/internal-lb-sg-id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.environment}/${var.project_name}/private_subnet_ids"
}

data "aws_ssm_parameter" "internal_alb_listner_arn" {
  name = "/${var.environment}/${var.project_name}/internal-alb-listner-arn"
}

