data "alicloud_zones" "default" {}

module "vpc" {
  source             = "alibaba/vpc/alicloud"
  create             = true
  vpc_name           = "my_module_vpc"
  vpc_cidr           = "172.16.0.0/16"
  vswitch_name       = "my_module_vswitch"
  vswitch_cidrs      = ["172.16.1.0/24"]
  availability_zones = [data.alicloud_zones.default.ids.0]
}

resource "alicloud_ess_scaling_group" "default" {
  min_size           = 1
  max_size           = 1
  scaling_group_name = "tf-essscalinggroupconfig-001"
  default_cooldown   = 20
  vswitch_ids        = [module.vpc.vswitch_ids[0]]
  removal_policies   = ["OldestInstance", "NewestInstance"]
}

module "ess_scaling_rule_simple" {
  source = "../../"
  create_simple_rule              = true
  create_target_tracking_rule     = false
  create_step_rule                = false
  create_alarm_task               = false
  create_scheduled_task           = false

  scaling_group_id    = alicloud_ess_scaling_group.default.id
  scaling_rule_name   = var.scaling_rule_simple_name
  adjustment_type     = var.adjustment_type
  adjustment_value    = var.adjustment_value
  cooldown            = var.cooldown
}

module "ess_scaling_rule_tracking" {
  source = "../../"
  create_simple_rule              = false
  create_target_tracking_rule     = true
  create_step_rule                = false
  create_alarm_task               = false
  create_scheduled_task           = false

  scaling_group_id    = alicloud_ess_scaling_group.default.id
  scaling_rule_name   = var.scaling_rule_tracking_name
  adjustment_type     = var.adjustment_type
  adjustment_value    = var.adjustment_value
  cooldown            = var.cooldown
  disable_scale_in    = var.disable_scale_in
}

module "ess_scaling_rule_step" {
  source = "../../"
  create_simple_rule              = false
  create_target_tracking_rule     = false
  create_step_rule                = true
  create_alarm_task               = false
  create_scheduled_task           = false

  scaling_group_id    = alicloud_ess_scaling_group.default.id
  scaling_rule_name   = var.scaling_rule_step_name
  adjustment_type     = var.adjustment_type
  adjustment_value    = var.adjustment_value
  cooldown            = var.cooldown
  step_adjustments    = var.step_adjustments
}

module "ess_alarm" {
  source = "../../"
  create_simple_rule              = false
  create_target_tracking_rule     = false
  create_step_rule                = false
  create_alarm_task               = true
  create_scheduled_task           = false

  scaling_group_id        = alicloud_ess_scaling_group.default.id
  alarm_task_name         = var.alarm_task_name
  enable_alarm_task       = var.enable_alarm_task
  alarm_task_metric_type  = "system"
  metric_name             = var.metric_name
  alarm_task_setting      = var.alarm_task_setting
}

module "ess_scheduled_task" {
  source = "../../"
  create_simple_rule              = false
  create_target_tracking_rule     = false
  create_step_rule                = false
  create_alarm_task               = false
  create_scheduled_task           = true
  scheduled_task_name             = "tf-essscheduleconfig"
  scheduled_task_setting          = var.scheduled_task_setting
  enable_scheduled_task           = var.enable_scheduled_task
}
