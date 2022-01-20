locals {
  default_ess_simple_rule_name    = substr("terraform-ess-simple-rule-${random_uuid.this.result}", 0, 40)
  default_ess_target_rule_name    = substr("terraform-ess-target-tracking-rule-${random_uuid.this.result}", 0, 40)
  default_ess_step_rule_name      = substr("terraform-ess-step-rule-${random_uuid.this.result}", 0, 40)
  default_ess_alarm_task_name     = "terraform-alarm-task-${random_uuid.this.result}"
  default_ess_scheduled_task_name = "terraform-scheduled-task-${random_uuid.this.result}"
  default_alarm_task_setting      = { period = 60, method = "Average", threshold = 0, comparison_operator = ">=", trigger_after : 3 }
  default_scheduled_task_setting  = { run_at = "2019-11-05T07:15Z", retry_interval = 600 }
  scaling_group_id                = var.scaling_group_id != "" ? var.scaling_group_id : var.scaling_group_name_regex != "" ? data.alicloud_ess_scaling_groups.this.ids.0 : ""
  alarm_task_name                 = var.alarm_task_name != "" ? var.alarm_task_name : local.default_ess_alarm_task_name
  alarm_task_setting              = length(var.alarm_task_setting) > 0 ? var.alarm_task_setting : local.default_alarm_task_setting
  scheduled_task_name             = var.scheduled_task_name != "" ? var.scheduled_task_name : local.default_ess_scheduled_task_name
  simple_rule_ari                 = var.create_simple_rule ? alicloud_ess_scaling_rule.simple.0.ari : ""
  simple_rule_cooldown            = var.cooldown != "" ? var.cooldown : data.alicloud_ess_scaling_groups.this.groups.0.cooldown_time
  step_rule_ari                   = var.create_step_rule ? alicloud_ess_scaling_rule.step.0.ari : ""
  target_tracking_rule_ari        = var.create_target_tracking_rule ? alicloud_ess_scaling_rule.target-tracking.0.ari : ""
  task_actions                    = length(var.task_actions) > 0 ? var.task_actions : compact([local.simple_rule_ari, local.step_rule_ari, local.target_tracking_rule_ari])
  scheduled_task_setting          = length(var.scheduled_task_setting) > 0 ? var.scheduled_task_setting : local.default_scheduled_task_setting
  number_of_simple_rule           = var.create_simple_rule ? 1 : 0
  number_of_target_tracking_rule  = var.create_target_tracking_rule ? 1 : 0
  number_of_step_rule             = var.create_step_rule ? 1 : 0
  number_of_scheduled_task        = local.number_of_simple_rule + local.number_of_target_tracking_rule + local.number_of_step_rule
  number_of_alarm_task            = local.number_of_scheduled_task > 0 ? 1 : 0
}

data "alicloud_ess_scaling_groups" "this" {
  ids        = var.scaling_group_id != "" ? [var.scaling_group_id] : null
  name_regex = var.scaling_group_name_regex
}

resource "random_uuid" "this" {
}