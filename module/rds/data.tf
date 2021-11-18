data "aws_availability_zones" "this" {
  state = "available"
}

data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "s3b-tfstate-cvsi"
    key    = "network.tfstate"
    region = "us-west-2"
  }
}