module "bastion_ec2" {
  depends_on             = [module.bastion]
  source                 = "../../../modules/ec2"
  environment            = var.environment
  project_name           = var.project_name
  ami                    = data.aws_ami.amazon_linux.id
  key_name               = "bapatlas.site"
  subnet_id              = element(module.expense-vpc.public_subnet_id, 0)
  instance_type          = "t3.micro"
  instance_name          = "bastion"
  vpc_security_group_ids = [module.bastion.sg_id]
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
      host        = module.bastion_ec2.public_ip
    }
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./bapatlas.site.pem")
      host        = module.bastion_ec2.public_ip
    }

    inline = [
      "sudo bash /tmp/setup.sh"
    ]
  }

  depends_on = [module.bastion_ec2]
}

module "vpn_ec2" {
  depends_on             = [module.vpn]
  source                 = "../../../modules/ec2"
  environment            = var.environment
  project_name           = var.project_name
  ami                    = data.aws_ami.openvpn.id
  key_name               = "bapatlas.site"
  subnet_id              = element(module.expense-vpc.public_subnet_id, 1)
  instance_type          = "t3a.small"
  instance_name          = "vpn"
  vpc_security_group_ids = [module.vpn.sg_id]
  common_tags            = var.common_tags
}


resource "aws_route53_record" "bastion" {
  zone_id = var.zone_id
  name    = "bastion.bapatlas.site"
  type    = "A"
  ttl     = 1
  records = [module.bastion_ec2.public_ip]
}