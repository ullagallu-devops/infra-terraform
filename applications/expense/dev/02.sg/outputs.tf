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