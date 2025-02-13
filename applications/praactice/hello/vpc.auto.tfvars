environment         = "practice"
project_name        = "hello"
vpc_cidr            = "10.1.0.0/16"
azs                 = ["us-east-1a", "us-east-1b"]
public_subnet_cidr  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnet_cidr = ["10.1.3.0/24", "10.1.4.0/24"]
db_subnet_cidr      = ["10.1.5.0/24", "10.1.6.0/24"]
common_tags = {
  "Terraform"   = "true"
  "Author"      = "sivaramakrishna"
  "Environment" = "practice"
  "Project"     = "expense"
}
enable_nat         = true
vpc_peering_enable = false