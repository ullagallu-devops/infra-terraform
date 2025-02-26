terraform {
    backend "s3" {
        bucket = "ecs-instana"
        key    = "eks-dev/terraform.tfstate"
        region = "us-east-1"
    }  
}