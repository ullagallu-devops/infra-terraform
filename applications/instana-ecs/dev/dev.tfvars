# common variable values
environment = "dev"
project_name = "instana"

# VPC variable values
azs = ["us-east-1a", "us-east-1b"]
vpc_cidr = "192.168.0.0/16"
public_subnet_cidr = ["192.168.1.0/24","192.168.2.0/24"]
private_subnet_cidr = ["192.168.3.0/24","192.168.4.0/24"]
db_subnet_cidr = ["192.168.5.0/24","192.168.6.0/24"]
vpc_common_tags = {
    Component = "vpc"
    Environment = "dev"
    Project = "instana_ecs"
    Terraform = "true"
    Developer = "Siva"
}
enable_nat = false
vpc_peering_enable = false

# SG variable values
bastion_sg_name = "bastion"
bastion_sg_description = "This security group is for bastion host"
bastion_common_tags = {
    Component = "bastion"
    Environment = "dev"
    Project = "instana_ecs"
    Terraform = "true"
    Developer = "Siva"
}


vpn_sg_name = "vpn"
vpn_sg_description = "This security group is for vpn host"
vpn_common_tags = {
    Component = "vpn"
    Environment = "dev"
    Project = "instana_ecs"
    Terraform = "true"
    Developer = "Siva"
}

mongo_sg_name = "mongo"
mongo_sg_description = "This security group is for mongo host"
mongo_common_tags = {
    Component = "mongo"
    Environment = "dev"
    Project = "instana_ecs"
    Terraform = "true"
    Developer = "Siva"
}

mysql_sg_name = "mysql"
mysql_sg_description = "This security group is for mysql host"
mysql_common_tags = {
    Component = "mysql"
    Environment = "dev"
    Project = "instana_ecs"
    Terraform = "true"
    Developer = "Siva"
}

redis_sg_name = "redis"
redis_sg_description = "This security group is for redis host"
redis_common_tags = {
    Component = "redis"
    Environment = "dev"
    Project = "instana_ecs"
    Terraform = "true"
    Developer = "Siva"
}

rabbitmq_sg_name = "rabbitmq"
rabbitmq_sg_description = "This security group is for rabbitmq host"
rabbitmq_common_tags = {
    Component = "rabbitmq"
    Environment = "dev"
    Project = "instana_ecs"
    Terraform = "true"
    Developer = "Siva"
}

catalogue_sg_name = "catalogue"
catalogue_sg_description = "This security group is for catalogue host"
catalogue_common_tags = {
    Component = "catalogue"
    Environment = "dev"
    Project = "instana_ecs"
    Terraform = "true"
    Developer = "Siva"
}

user_sg_name = "user"
user_sg_description = "This security group is for user host"
user_common_tags = {
    Component = "user"
    Environment = "dev"
    Project = "instana_ecs"
    Terraform = "true"
    Developer = "Siva"
}

cart_sg_name = "cart"
cart_sg_description = "This security group is for cart host"
cart_common_tags = {
    Component = "cart"
    Environment = "dev"
    Project = "instana_ecs"
    Terraform = "true"
    Developer = "Siva"
}

shipping_sg_name = "shipping"
shipping_sg_description = "This security group is for shipping host"
shipping_common_tags = {
    Component = "shipping"
    Environment = "dev"
    Project = "instana_ecs"
    Terraform = "true"
    Developer = "Siva"
}

payment_sg_name = "payment"
payment_sg_description = "This security group is for payment host"
payment_common_tags = {
    Component = "payment"
    Environment = "dev"
    Project = "instana_ecs"
    Terraform = "true"
    Developer = "Siva"
}

frontend_sg_name = "frontend"
frontend_sg_description = "This security group is for frontend host"
frontend_common_tags = {
    Component = "frontend"
    Environment = "dev"
    Project = "instana_ecs"
    Terraform = "true"
    Developer = "Siva"
}

alb_sg_name = "alb"
alb_sg_description = "This security group is for alb host"
alb_common_tags = {
    Component = "alb"
    Environment = "dev"
    Project = "instana_ecs"
    Terraform = "true"
    Developer = "Siva"
}

# ECS variable values
role_name = "ecs_task_execution_role"
enable_service_role = false