### Module usage
```hcl
module "cart_service" {
  source                = "./modules/ecs_service"
  name                  = "cart-service"
  cluster_arn           = "arn:aws:ecs:ap-south-1:427366301535:cluster/my-cluster"
  task_definition       = module.cart_task_definition.task_definition_arn
  desired_count         = 2
  launch_type           = "FARGATE"
  subnets               = ["subnet-12345678", "subnet-87654321"]
  security_groups       = ["sg-12345678"]
  assign_public_ip      = true
  enable_ecs_managed_tags = true
  propagate_tags        = "SERVICE"

  service_discovery_enabled = true
  service_discovery_arn     = "arn:aws:servicediscovery:ap-south-1:427366301535:service/srv-12345678"

  tags = {
    Environment = "production"
    Application = "cart-service"
  }
}
```