module "mysql_expense" {
  source                 = "../../../../modules/rds"
  environment            = var.environment
  project_name           = var.project_name
  common_tags            = var.common_tags
  db_name                = "transactions"
  port                   = "3306"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "ExpenseApp1"
  db_subnet_group_name   = data.aws_ssm_parameter.db_subnet_group.value
  skip_final_snapshot    = true
  vpc_security_group_ids = [data.aws_ssm_parameter.db_sg_id.value]
}

resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "${var.environment}-${var.project_name}"
  type    = "CNAME"
  ttl     = 300
  records = [module.mysql_expense.db_address]
}