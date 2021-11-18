# security_group
module "security_group" {
  source = "../../resource/security_group"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  name   = "sg1"
  ingress_rule = {
    1 = {
      description = "web port"
      from_port   = 8080,
      to_port     = 8080,
      protocol    = "tcp"
      cidr_blocks = ["49.106.215.209/32", "217.0.0.0/8", "10.0.0.0/16"]
    },
    2 = {
      description = "SSH port"
      from_port   = 22,
      to_port     = 22,
      protocol    = "tcp"
      cidr_blocks = ["49.106.215.209/32", "217.0.0.0/8"]
    }
  }
}

# alb用セキュリティグループ
module "security_group_alb" {
  source = "../../resource/security_group"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  name   = "sg_alb"
  ingress_rule = {
    1 = {
      description = "web port"
      from_port   = 80,
      to_port     = 80,
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

module "alb" {
  source                     = "../../resource/elb"
  alb_name                   = "alb"
  security_groups            = [module.security_group_alb.security_group_id]
  subnets = data.terraform_remote_state.network.outputs.public_subnet_ids
  internal                   = false
  enable_deletion_protection = false
  access_logs = [
    {
      enabled = true
      bucket  = "s3b-alb-accesslog-cvsi"
      prefix  = "alb"
    }
  ]
  target_group_name              = "web"
  target_port                    = 8080
  target_protocol                = "HTTP"
  interval                       = 300
  path                           = "/"
  vpc_id                         = data.terraform_remote_state.network.outputs.vpc_id
  health_check_port              = 8080
  unhealthy_threshold            = 10
  health_check_protocol          = "HTTP"
  timeout                        = 60
  matcher                        = 200
  listener_port                  = "80"
  listener_protocol              = "HTTP"
  listener_default_action_type   = "forward"
  listener_rule_priority         = 100
  listener_rule_action_type      = "forward"
  listener_rule_condition_field  = "path-pattern"
  listener_rule_condition_values = ["/"]
  tags                           = var.tags
}

# autoscaling
module "autoscaling" {
  source = "../../resource/autoscaling"

  launch_template_name = "IaaS-template"
  image_id             = "ami-098697f008d0ac179"
  instance_type        = "t2.micro"
  key_name             = "cvsi"

  eni_delete_on_termination = true
  security_group_ids        = [module.security_group.security_group_id]
  autoscaling_group_name    = "autoscaling-name"
  subnet_ids                = data.terraform_remote_state.network.outputs.public_subnet_ids
  max_size                  = 2
  min_size                  = 2
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  instance_name             = "IaaS-template-instance"
  tags = {
    Created = "terraform"
  }

  alb_target_group_arn = module.alb.alb_target_group_arn

  block_device_mappings = [
    {
      device_name = "/dev/xvda"
      ebs = [
        {
          volume_type               = "gp2"
          volume_size               = 8
          ebs_delete_on_termination = true
        }
      ]
    }
  ]
}