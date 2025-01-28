output "internal_http_listner_arn" {
  value = module.expense_internal.http_listner
}

output "external_http_listner_arn" {
  value = module.expense_external.http_listner
}
output "external_https_listner_arn" {
  value = module.expense_external.https_listner
}
