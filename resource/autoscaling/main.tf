# --------------------------------------------------------------------------------
# aws_launch_template resource definition
# @see https://www.terraform.io/docs/providers/aws/r/launch_template.html
# --------------------------------------------------------------------------------

resource "aws_launch_template" "this" {
  name = var.launch_template_name

  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name  = lookup(block_device_mappings.value, "device_name", null)
      no_device    = lookup(block_device_mappings.value, "no_device", null)
      virtual_name = lookup(block_device_mappings.value, "virtual_name", null)

      dynamic "ebs" {
        for_each = flatten(list(lookup(block_device_mappings.value, "ebs", [])))
        content {
          delete_on_termination = lookup(ebs.value, "ebs_delete_on_termination", null)
          encrypted             = lookup(ebs.value, "encrypted", null)
          iops                  = lookup(ebs.value, "iops", null)
          kms_key_id            = lookup(ebs.value, "kms_key_id", null)
          snapshot_id           = lookup(ebs.value, "snapshot_id", null)
          volume_size           = lookup(ebs.value, "volume_size", null)
          volume_type           = lookup(ebs.value, "volume_type", null)
        }
      }
    }
  }

  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = var.user_data

  iam_instance_profile {
    name = var.instance_profile_name
  }

  network_interfaces {
    description                 = var.launch_template_name
    device_index                = var.device_index
    associate_public_ip_address = var.associate_public_ip_address
    delete_on_termination       = var.eni_delete_on_termination
    security_groups             = var.security_group_ids
  }

  tags = merge(var.tags, { "Name" = var.launch_template_name })

  lifecycle {
    create_before_destroy = true
  }
}

# --------------------------------------------------------------------------------
# aws_autoscaling_group resource definition
# @see https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
# --------------------------------------------------------------------------------

resource "aws_autoscaling_group" "this" {
  name                      = var.autoscaling_group_name
  vpc_zone_identifier       = var.subnet_ids
  max_size                  = var.max_size
  min_size                  = var.min_size
  load_balancers            = var.load_balancers
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  min_elb_capacity          = var.min_elb_capacity
  wait_for_elb_capacity     = var.wait_for_elb_capacity
  target_group_arns         = var.target_group_arns
  default_cooldown          = var.default_cooldown
  force_delete              = var.force_delete
  termination_policies      = var.termination_policies
  suspended_processes       = var.suspended_processes
  placement_group           = var.placement_group
  enabled_metrics           = var.enabled_metrics
  metrics_granularity       = var.metrics_granularity
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  protect_from_scale_in     = var.protect_from_scale_in
  service_linked_role_arn   = var.service_linked_role_arn

  launch_template {
    id      = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version
  }

  tags = flatten([
    for key in keys(local.tags) :
    {
      key                 = key
      value               = local.tags[key]
      propagate_at_launch = true
    }
  ])

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [target_group_arns]
  }
}

# --------------------------------------------------------------------------------
# aws_autoscaling_attachment resource definition
# @see https://www.terraform.io/docs/providers/aws/r/autoscaling_attachment.html
# --------------------------------------------------------------------------------

resource "aws_autoscaling_attachment" "this" {
  alb_target_group_arn   = var.alb_target_group_arn
  autoscaling_group_name = aws_autoscaling_group.this.id
}

# --------------------------------------------------------------------------------
# aws_autoscaling_policy resource definition
# @see https://www.terraform.io/docs/providers/aws/r/autoscaling_policy.html
# --------------------------------------------------------------------------------

resource "aws_autoscaling_policy" "this" {
  for_each               = var.autoscaling_policies
  name                   = each.value.name
  autoscaling_group_name = aws_autoscaling_group.this.name
  adjustment_type        = lookup(each.value, "adjustment_type", null)
  cooldown               = lookup(each.value, "cooldown", null)
  scaling_adjustment     = lookup(each.value, "scaling_adjustment", null)
}
