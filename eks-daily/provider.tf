terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.2"
    }
  }
  backend "s3" {
    bucket = "eks-siva.bapatlas.site"
    key    = "eks-daily/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "eks-siva.bapatlas.site"
  }
}

provider "aws" {
  region  = "ap-south-1"
}