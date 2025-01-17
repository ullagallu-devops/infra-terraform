variable "environment" {
    description = "The environment in which the resources are created"
    type        = string
}
variable "project_name" {
    description = "The name of the project"
    type        = string
}
variable "common_tags" {
    description = "The common tags to be attached to the resources"
    type        = map
}
variable "db_name" {}
variable "port" {}
variable "vpc_security_group_ids" {}
variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
}
variable "engine" {
    description = "The database engine"
    type        = string
}
variable "engine_version" {
    description = "The database engine version"
    type        = string
}
variable "instance_class" {
    description = "The instance class"
    type        = string
}
variable "username" {
    description = "The username for the database"
    type        = string
}
variable "password" {
    description = "The password for the database"
    type        = string
}
variable "db_subnet_group_name" {
    description = "The name of the parameter group"
    type        = string
}
variable "skip_final_snapshot" {
    description = "Whether to skip the final snapshot"
    type        = bool
}

