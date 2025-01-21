locals {
  public_subnet_id = element(split(",", data.aws_ssm_parameter.public_subnet_ids.value), 0)
}
module "bastion" {
  source                 = "../../../../modules/ec2"
  environment            = var.environment
  project_name           = var.project_name
  ami                    = data.aws_ami.amazon_linux.id
  key_name               = "bapatlas.site"
  subnet_id              = local.public_subnet_id
  instance_type          = "t3.micro"
  instance_name          = "bastion"
  vpc_security_group_ids = [data.aws_ssm_parameter.bastion.value]
  common_tags            = var.common_tags
}
resource "null_resource" "bastion" {

  provisioner "file" {
    source      = "./bastion-script.sh"
    destination = "/tmp/setup.sh"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./bapatlas.site.pem")
      host        = module.bastion.public_ip
    }
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./bapatlas.site.pem")
      host        = module.bastion.public_ip
    }

    inline = [
      "sudo bash /tmp/setup.sh"
    ]
  }

  depends_on = [module.bastion]
}

# For testing to get error remove sudo
# once the error was get 
# again run script with sudo privileges
# Observe the taint and untaint
# terraform taint <resource-name>.<local-name>
# terraform untaint <resource-name>.<local-name>
# If we taint the resource on next apply the resource was recreated
# untaint was used to avoid resource re-creation

module "vpn" {
  source                 = "../../../../modules/ec2"
  environment            = var.environment
  project_name           = var.project_name
  ami                    = data.aws_ami.openvpn.id
  key_name               = "bapatlas.site"
  subnet_id              = local.public_subnet_id
  instance_type          = "t3a.small"
  instance_name          = "vpn"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn.value]
  common_tags            = var.common_tags
}


resource "aws_route53_record" "bastion" {
  zone_id = var.zone_id
  name    = "bastion.bapatlas.site"
  type    = "A"
  ttl     = 1
  records = [module.bastion.public_ip]
}

