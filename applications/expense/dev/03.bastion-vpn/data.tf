data "aws_ssm_parameter" "bastion" {
  name = "/${var.environment}/${var.project_name}/bastion-sg-id"
}
data "aws_ssm_parameter" "vpn" {
  name = "/${var.environment}/${var.project_name}/vpn-sg-id"
}
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.environment}/${var.project_name}/public_subnet_ids"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_ami" "openvpn" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image-fe8020db-*"]
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