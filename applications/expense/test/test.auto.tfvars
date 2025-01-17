### common variable values
environment  = "test"
project_name = "expense"
common_tags = {
  "Terraform"   = "true"
  "Author"      = "sivaramakrishna"
  "Environment" = "test"
  "Project"     = "expense"
}
zone_id = "Z04410211MZ57SQOXFNI3"
### vpc variable values
vpc_cidr            = "192.168.0.0/16"
azs                 = ["us-east-1a", "us-east-1b"]
public_subnet_cidr  = ["192.168.1.0/24", "192.168.2.0/24"]
private_subnet_cidr = ["192.168.3.0/24", "192.168.4.0/24"]
db_subnet_cidr      = ["192.168.5.0/24", "192.168.6.0/24"]

enable_nat         = false
vpc_peering_enable = false