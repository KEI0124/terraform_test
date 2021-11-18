/**
* ## Terraform Document
*
* * [aws_lb](https://www.terraform.io/docs/providers/aws/r/lb.html)
* * [aws_lb_target_group](https://www.terraform.io/docs/providers/aws/r/lb_target_group.html)
* * [aws_lb_listener](https://www.terraform.io/docs/providers/aws/r/lb_listener.html)
* * [aws_lb_listener_rule](https://www.terraform.io/docs/providers/aws/r/lb_listener_rule.html)
*
* ## Usage
* 
* ```hcl
* module "alb" {
*   source                     = "git::https://git-codecommit.us-east-1.amazonaws.com/v1/repos/SATT-POC//module/elb/v2"
*   alb_name                   = "ELB-DEV-CNT-AWS-WXSWLB"
*   security_groups            = ["sg-0559161bb7f976015"]
*   subnets                    = ["subnet-0b8f5c0a725c9a101", "subnet-04b1d40f851fea932"]
*   internal                   = true
*   enable_deletion_protection = false
*   access_logs                 = [
*     {
*       enabled = true
*       bucket  = "s3b-poc-all-aws-log"
*       prefix  = "elb/ELB-DEV-CNT-AWS-WXSWLB"
*     }
*   ]
*   target_group_name              = "TGR-DEV-CNT-AWS-WXSWB"
*   target_port                    = 80
*   target_protocol                = "HTTP"
*   interval                       = 300
*   path                           = "/server-status"
*   vpc_id                         = "vpc-0030192565c49c55f"
*   health_check_port              = 80
*   unhealthy_threshold            = 10
*   health_check_protocol          = "HTTP"
*   timeout                        = 60
*   matcher                        = 200
*   listener_port                  = "80"
*   listener_protocol              = "HTTP"
*   listener_default_action_type   = "forward"
*   listener_rule_priority         = 100
*   listener_rule_action_type      = "forward"
*   listener_rule_condition_field  = "path-pattern"
*   listener_rule_condition_values = ["/target/*"]
*   tags                           = var.tags
* }
* ```
*
*/

# --------------------------------------------------------------------------------
# aws_alb resource definition
# @see https://www.terraform.io/docs/providers/aws/r/lb.html
# --------------------------------------------------------------------------------

resource "aws_alb" "this" {
  name               = var.alb_name
  load_balancer_type = var.load_balancer_type
  internal           = var.internal
  security_groups    = var.load_balancer_type == "application" ? var.security_groups : null
  subnets            = var.subnets

  idle_timeout                     = var.idle_timeout
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  enable_deletion_protection       = var.enable_deletion_protection
  enable_http2                     = var.enable_http2
  ip_address_type                  = var.ip_address_type
  drop_invalid_header_fields       = var.drop_invalid_header_fields

  dynamic "access_logs" {
    for_each = var.access_logs
    content {
      enabled = access_logs.value.enabled
      bucket  = access_logs.value.bucket
      prefix  = access_logs.value.prefix
    }
  }

  tags = merge(var.tags, { "Name" = var.alb_name })
}

# --------------------------------------------------------------------------------
# aws_alb_target_group resource definition
# @see https://www.terraform.io/docs/providers/aws/r/lb_target_group.html
# --------------------------------------------------------------------------------

resource "aws_alb_target_group" "this" {
  name        = var.target_group_name
  vpc_id      = var.vpc_id
  port        = var.target_port
  protocol    = var.target_protocol
  target_type = var.target_type

  deregistration_delay               = var.deregistration_delay
  slow_start                         = var.slow_start
  proxy_protocol_v2                  = var.proxy_protocol_v2
  lambda_multi_value_headers_enabled = var.lambda_multi_value_headers_enabled

  health_check {
    enabled             = var.enabled
    interval            = var.interval
    path                = var.path
    port                = var.health_check_port
    protocol            = var.health_check_protocol
    timeout             = var.timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    matcher             = var.matcher
  }

  tags = merge(var.tags, { "Name" = var.target_group_name })

  depends_on = [aws_alb.this]

  lifecycle {
    create_before_destroy = true
  }
}

#resource "aws_lb_target_group_attachment" "this" {
#  target_group_arn = aws_alb_target_group.this.arn
#  target_id        = var.target_id
#  port             = var.listener_port
#}

# --------------------------------------------------------------------------------
# aws_alb_listener resource definition
# @see https://www.terraform.io/docs/providers/aws/r/lb_listener.html
# --------------------------------------------------------------------------------

resource "aws_alb_listener" "this" {
  load_balancer_arn = aws_alb.this.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  # Defaults to forward action if action_type not specified
  default_action {
    type             = var.listener_default_action_type
    target_group_arn = aws_alb_target_group.this.arn
  }

  depends_on = [aws_alb_target_group.this]
}

# --------------------------------------------------------------------------------
# aws_alb_listener_rule resource definition
# @see https://www.terraform.io/docs/providers/aws/r/lb_listener_rule.html
# --------------------------------------------------------------------------------

resource "aws_alb_listener_rule" "this" {
  count        = var.load_balancer_type == "application" ? 1 : 0
  listener_arn = aws_alb_listener.this.arn
  priority     = var.listener_rule_priority

  action {
    target_group_arn = aws_alb_target_group.this.id
    type             = var.listener_rule_action_type
  }

  condition {
    path_pattern {
      values = var.listener_rule_condition_values
    }
  }
  
  depends_on = [aws_alb_listener.this]
}