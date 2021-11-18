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

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }
}
