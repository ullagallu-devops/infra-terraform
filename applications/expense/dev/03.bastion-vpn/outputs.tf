output "bastion_public_ip" {
  value = module.bastion.public_ip
}
output "vpn_public_ip" {
  value = module.vpn.public_ip
}

output "al2023" {
  value = data.aws_ami.amazon_linux.id
}
output "openvpn" {
  value = data.aws_ami.openvpn.id
}