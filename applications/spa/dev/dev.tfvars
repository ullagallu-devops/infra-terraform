environment = "dev"
project_name = "spa"

azs = ["us-east-1a", "us-east-1b"]
vpc_cidr = "192.168.0.0/16"
public_subnet_cidr = ["192.168.1.0/24","192.168.2.0/24"]
private_subnet_cidr = ["192.168.3.0/24","192.168.4.0/24"]
db_subnet_cidr = ["192.168.5.0/24","192.168.6.0/24"]
vpc_common_tags = {
    Component = "vpc"
    Environment = "dev"
    Project = "app-modernization"
    Terraform = "true"
    Developer = "Siva"
}
enable_nat = false
vpc_peering_enable = false

bastion_sg_name = "bastion"
bastion_sg_description = "This security group is for bastion host"
bastion_common_tags = {
    Component = "bastion-sg"
    Environment = "dev"
    Project = "spa"
    Terraform = "true"
    Developer = "Siva"
}

vpn_sg_name = "vpn"
vpn_sg_description = "This security group is for vpn host"
vpn_common_tags = {
    Component = "vpn-sg"
    Environment = "dev"
    Project = "spa"
    Terraform = "true"
    Developer = "Siva"
}

backend_sg_name = "backend"
backend_sg_description = "This security group is for backend host"
backend_common_tags = {
    Component = "backend-sg"
    Environment = "dev"
    Project = "spa"
    Terraform = "true"
    Developer = "Siva"
}

db_sg_name = "db"
db_sg_description = "This security group is for db host"
db_common_tags = {
    Component = "db-sg"
    Environment = "dev"
    Project = "spa"
    Terraform = "true"
    Developer = "Siva"
}

alb_sg_name = "alb"
alb_sg_description =  "This security group is for alb host"
alb_common_tags = {
    Component = "alb-sg"
    Environment = "dev"
    Project = "spa"
    Terraform = "true"
    Developer = "Siva"
}
