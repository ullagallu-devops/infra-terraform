terraform {
    backend "s3" {
        bucket = "ecs-instana"
        key    = "dev/terraform.tfstate"
        region = "us-east-1"
    }  
}