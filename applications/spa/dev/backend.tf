terraform {
    backend "s3" {
        bucket = "spa-infra-dev-bapatlas.site"
        key    = "terraform.tfstate"
        region = "us-east-1"
    }  
}

