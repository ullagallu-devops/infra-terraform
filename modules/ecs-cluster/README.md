### Module usage
```hcl
module "ecs_cluster" {
  source           = "./modules/ecs_cluster"
  cluster_name     = "my-ecs-cluster"
  vpc_id           = "vpc-12345678"
  subnet_ids       = ["subnet-12345678", "subnet-87654321"]
  enable_logging   = true
  log_group_prefix = "/ecs/my-ecs-cluster"
}
```