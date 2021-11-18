# key_pair
module "key_pair" {
  source              = "../../resource/key_pair"
  ssh_public_key_path = "../../secrets"
  key_name            = "cvsi"
}

# security_group
module "security_group" {
  source = "../../resource/security_group"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  name   = "sg_ec2"
  ingress_rule = {
    1 = {
      description = "SSH port"
      from_port   = 22,
      to_port     = 22,
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    2 = {
      description = "tomcat port"
      from_port   = 8080,
      to_port     = 8080,
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

# ec2
module "ec2" {
  source                      = "../../resource/ec2"
  name                        = "test"
  instance_count              = 1
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.small"
  key_name                    = module.key_pair.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [module.security_group.security_group_id]
  subnet_ids                  = data.terraform_remote_state.network.outputs.public_subnet_ids
  root_block_device = [
    {
      volume_type           = "gp2"
      volume_size           = 8
      delete_on_termination = true
    }
  ]
  tags = var.tags
}
