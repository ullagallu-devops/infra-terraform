output "vpc_id" {
  value = module.vpc_module.vpc_id
}
output "public_subnet_ids" {
  value = module.vpc_module.public_subnet_ids
}
output "private_subnet_ids" {
  value = module.vpc_module.private_subnet_ids
}
output "db_subnet_ids" {
  value = module.vpc_module.db_subnet_ids
}
output "db_sg_name" {
  value = module.vpc_module.db_subnet_group
}
output "bastion_sg_id" {
  value = module.bastion.sg_id
}
output "vpn_sg_id" {
  value = module.vpn.sg_id
}
output "backend_sg_id" {
  value = module.backend.sg_id
}
output "db_sg_id" {
  value = module.db.sg_id
}
output "alb_sg_id" {
  value = module.alb.sg_id
}
