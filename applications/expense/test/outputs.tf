### vpc outputs
output "vpc_id" {
  value = module.expense_vpc.vpc_id
}
output "public_subnet_id" {
  value = module.expense_vpc.public_subnet_id
}
output "private_subnet_cidr" {
  value = module.expense_vpc.private_subnet_id
}
output "db_subnet_cidr" {
  value = module.expense_vpc.db_subnet_id
}
output "db_subnet_group_name" {
  value = module.expense_vpc.db_subnet_group
}

### sg outputs
output "bastion_sg_id" {
  value = module.bastion.sg_id
}
output "vpn_sg_id" {
  value = module.vpn.sg_id
}
output "db_sg_id" {
  value = module.db.sg_id
}
output "backend_sg_id" {
  value = module.backend.sg_id
}
output "frontend_sg_id" {
  value = module.frontend.sg_id
}
output "internal_lb_sg_id" {
  value = module.internal_lb.sg_id
}
output "external_lb_sg_id" {
  value = module.external_lb.sg_id
}

### ec2 instances outputs
output "bastion_public_ip" {
  value = module.bastion_ec2.public_ip
}
output "vpn_public_ip" {
  value = module.vpn_ec2.public_ip
}

output "al2023" {
  value = data.aws_ami.amazon_linux.id
}
output "openvpn" {
  value = data.aws_ami.openvpn.id
}

# DB DNS
output "address" {
  value = module.mysql_expense.db_address
}

# Internal and external alb & listner arns
output "internal_alb_arn" {
  value = module.internal_lb1.alb_arn
}
output "internal_alb_listner_arn" {
  value = module.internal_lb1.internal_listner
}

output "external_alb_arn" {
  value = module.external_lb1.alb_arn
}
output "external_alb_listner_arn" {
  value = module.external_lb1.internal_listner
}