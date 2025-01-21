variable "environment" {
  default = "dev"
}
variable "project_name" {
  default = "expense"
}

variable "common_tags" {
  default = {
    "Terraform"   = "true"
    "Author"      = "sivaramakrishna"
    "Environment" = "dev"
    "Project"     = "expense"
  }
}


variable "zone_name" {
  default = "bapatlas.site"
}