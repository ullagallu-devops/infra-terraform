output "internal_alb_arn" {
  value = module.internal_lb.alb_arn
}
output "internal_alb_listner_arn" {
  value = module.internal_lb.internal_listner
}

output "external_alb_arn" {
  value = module.external_lb.alb_arn
}
output "external_alb_listner_arn" {
  value = module.external_lb.internal_listner
}