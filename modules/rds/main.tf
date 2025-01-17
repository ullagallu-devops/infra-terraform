locals {
  name = "${var.environment}-${var.project_name}"
}
resource "aws_db_instance" "default" {
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  port = var.port
  identifier = local.name
  password             = var.password
  db_subnet_group_name = var.db_subnet_group_name
  skip_final_snapshot  = var.skip_final_snapshot
 vpc_security_group_ids = var.vpc_security_group_ids
  tags = merge(
    var.common_tags,
    {
      Name = local.name
    }
  )
}