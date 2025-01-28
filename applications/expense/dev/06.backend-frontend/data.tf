data "aws_ssm_parameter" "internal_http_listner" {
  name  = "/${var.environment}/${var.project_name}/internal-http-listner"

}
data "aws_ssm_parameter" "external_http_listner" {
  name  = "/${var.environment}/${var.project_name}/external-http-listner"
}
data "aws_ssm_parameter" "external_https_listner" {
  name  = "/${var.environment}/${var.project_name}/external-https-listner"
}
data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.environment}/${var.project_name}/private_subnet_ids"
}
data "aws_ssm_parameter" "backend" {
  name  = "/${var.environment}/${var.project_name}/backend-sg-id"
}
data "aws_ssm_parameter" "frontend" {
  name  = "/${var.environment}/${var.project_name}/frontend-sg-id"
}
data "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.environment}/${var.project_name}/vpc_id"
}
data "aws_ami" "backend" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["backend-*"]
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
data "aws_ami" "frontend" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["frontend-*"]
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