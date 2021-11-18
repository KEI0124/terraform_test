# backend
terraform {
  backend "s3" {
    bucket  = "s3b-tfstate-cvsi"
    region  = "us-west-2"
    key     = "elb.tfstate"
    encrypt = true
  }
}

provider "aws" {
  profile = "default"
  region = "us-west-2"
  version = "2.70.0"
}

terraform {
  required_version = "~> 0.12.0"

  required_providers {
    #aws   = "~> 3.2.0"
    local = "~> 1.4"
    tls   = "~> 2.2"
  }
}
