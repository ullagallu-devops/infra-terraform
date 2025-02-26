module "instana_iam" {
  source = "./modules/instana-iam"
  environment = var.environment
  project_name = var.project_name
  role_name = var.ecs_role_name
  enable_service_role = var.enable_service_role
}