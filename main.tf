// A simple scaling rule
resource "alicloud_ess_scaling_rule" "simple" {
  count             = local.number_of_simple_rule
  scaling_group_id  = local.scaling_group_id
  scaling_rule_name = var.scaling_rule_name != "" ? var.scaling_rule_name : local.default_ess_simple_rule_name
  scaling_rule_type = "SimpleScalingRule"
  adjustment_type   = var.adjustment_type
  adjustment_value  = var.adjustment_value
  cooldown          = local.simple_rule_cooldown
}

// A target tracking scaling rule
resource "alicloud_ess_scaling_rule" "target-tracking" {
  count                     = local.number_of_target_tracking_rule
  scaling_group_id          = local.scaling_group_id
  scaling_rule_name         = var.scaling_rule_name != "" ? var.scaling_rule_name : local.default_ess_target_rule_name
  scaling_rule_type         = "TargetTrackingScalingRule"
  estimated_instance_warmup = var.estimated_instance_warmup
  metric_name               = var.metric_name
  target_value              = var.target_value
  disable_scale_in          = var.disable_scale_in
}

// A step scaling rule
resource "alicloud_ess_scaling_rule" "step" {
  count                     = local.number_of_step_rule
  scaling_group_id          = local.scaling_group_id
  scaling_rule_name         = var.scaling_rule_name != "" ? var.scaling_rule_name : local.default_ess_step_rule_name
  scaling_rule_type         = "StepScalingRule"
  adjustment_type           = var.adjustment_type
  estimated_instance_warmup = var.estimated_instance_warmup
  dynamic "step_adjustment" {
    for_each = var.step_adjustments
    content {
      metric_interval_lower_bound = lookup(step_adjustment.value, "lower_limit", null)
      metric_interval_upper_bound = lookup(step_adjustment.value, "upper_limit", null)
      scaling_adjustment          = lookup(step_adjustment.value, "adjustment_value", null)
    }
  }
}

// A alarm task
resource "alicloud_ess_alarm" "this" {
  count               = var.create_alarm_task == true ? local.number_of_alarm_task : 0
  scaling_group_id    = local.scaling_group_id
  name                = local.alarm_task_name
  description         = "An alarm task came from terraform-alicloud-modules/autoscaling-rule"
  enable              = var.enable_alarm_task
  alarm_actions       = local.task_actions
  metric_type         = var.alarm_task_metric_type
  metric_name         = var.alarm_task_metric_name
  period              = lookup(local.alarm_task_setting, "period", null)
  statistics          = lookup(local.alarm_task_setting, "method", null)
  threshold           = lookup(local.alarm_task_setting, "threshold", null)
  comparison_operator = lookup(local.alarm_task_setting, "comparison_operator", null)
  evaluation_count    = lookup(local.alarm_task_setting, "trigger_after", null)
}

// Several scheduled tasks
resource "alicloud_ess_scheduled_task" "this" {
  count                  = var.create_scheduled_task == true ? local.number_of_scheduled_task : 0
  scheduled_action       = local.task_actions[count.index]
  scheduled_task_name    = join("", [local.scheduled_task_name, count.index + 1])
  description            = join("", ["A scheduled task comes from terraform-alicloud-modules/autoscaling-rule and trigger the rule ", local.task_actions[count.index]])
  launch_time            = lookup(local.scheduled_task_setting, "run_at", null)
  launch_expiration_time = lookup(local.scheduled_task_setting, "retry_interval", null)
  recurrence_type        = lookup(local.scheduled_task_setting, "recurrence_type", null)
  recurrence_value       = lookup(local.scheduled_task_setting, "recurrence_value", null)
  recurrence_end_time    = lookup(local.scheduled_task_setting, "end_at", null)
  task_enabled           = var.enable_scheduled_task
  depends_on             = [alicloud_ess_scaling_rule.simple, alicloud_ess_scaling_rule.target-tracking, alicloud_ess_scaling_rule.step]
}