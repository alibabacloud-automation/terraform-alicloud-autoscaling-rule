data "alicloud_zones" "default" {
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_ess_scaling_group" "default" {
  min_size           = 1
  max_size           = 1
  scaling_group_name = local.scaling_simple_rule_name
  vswitch_ids        = module.vpc.this_vswitch_ids
  removal_policies   = ["OldestInstance", "NewestInstance"]
}

module "vpc" {
  source  = "alibaba/vpc/alicloud"
  version = "1.11.0"

  create             = true
  vpc_cidr           = "172.16.0.0/16"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_zones.default.zones[0].id]
}

# A simple scaling rule
module "simple_rule" {
  source = "../.."

  # A simple scaling rule
  create_simple_rule = true

  scaling_group_id            = alicloud_ess_scaling_group.default.id
  scaling_simple_rule_name    = local.scaling_simple_rule_name
  scaling_group_name_regex    = "terraform-ess-"
  simple_rule_adjustment_type = var.simple_rule_adjustment_type
  adjustment_value            = var.adjustment_value
  cooldown                    = var.cooldown

  # A target tracking scaling rule
  create_target_tracking_rule = false

  # A step scaling rule
  create_step_rule = false

  # A alarm task
  create_alarm_task = false

  # Several scheduled tasks
  create_scheduled_task = false

}

# A target tracking scaling rule
module "target_tracking_rule" {
  source = "../.."

  # A simple scaling rule
  create_simple_rule = false

  # A target tracking scaling rule
  create_target_tracking_rule = true

  scaling_group_id                               = module.simple_rule.this_autoscaling_group_id
  scaling_group_name_regex                       = "terraform-ess-"
  scaling_target_tracking_rule_name              = var.scaling_target_tracking_rule_name
  target_tracking_rule_estimated_instance_warmup = var.target_tracking_rule_estimated_instance_warmup
  target_tracking_rule_metric_name               = var.target_tracking_rule_metric_name
  target_value                                   = var.target_value
  disable_scale_in                               = var.disable_scale_in

  # A step scaling rule
  create_step_rule = false

  # A alarm task
  create_alarm_task = false

  # Several scheduled tasks
  create_scheduled_task = false

}

# A step scaling rule
module "step_rule" {
  source = "../.."

  # A simple scaling rule
  create_simple_rule = false

  # A target tracking scaling rule
  create_target_tracking_rule = false

  # A step scaling rule
  create_step_rule = true

  scaling_group_id                    = module.target_tracking_rule.this_autoscaling_group_id
  scaling_group_name_regex            = "terraform-ess-"
  scaling_step_rule_name              = var.scaling_step_rule_name
  step_rule_adjustment_type           = "TotalCapacity"
  step_rule_estimated_instance_warmup = 300
  step_adjustments                    = var.step_adjustments

  # A alarm task
  create_alarm_task = false

  # Several scheduled tasks
  create_scheduled_task = false

}

# A alarm task
module "alarm_task" {
  source = "../.."

  # A simple scaling rule
  create_simple_rule = false

  # A target tracking scaling rule
  create_target_tracking_rule = false

  # A step scaling rule
  create_step_rule = false

  # A alarm task
  create_alarm_task = true

  scaling_group_id         = module.step_rule.this_autoscaling_group_id
  scaling_group_name_regex = "terraform-ess-"
  alarm_task_name          = var.alarm_task_name
  alarm_description        = var.alarm_description
  enable_alarm_task        = var.enable_alarm_task
  task_actions             = [module.simple_rule.this_autoscaling_simple_rule_ari, module.target_tracking_rule.this_autoscaling_target_tracking_rule_ari, module.step_rule.this_autoscaling_step_rule_ari]
  alarm_task_metric_type   = "system"
  alarm_task_metric_name   = var.alarm_task_metric_name
  alarm_task_setting       = var.alarm_task_setting

  # Several scheduled tasks
  create_scheduled_task = false

}

# Several scheduled tasks
module "scheduled_task" {
  source = "../.."

  # A simple scaling rule
  create_simple_rule = false

  # A target tracking scaling rule
  create_target_tracking_rule = false

  # A step scaling rule
  create_step_rule = false

  # A alarm task
  create_alarm_task = false

  # Several scheduled tasks
  create_scheduled_task = true

  task_actions               = [module.simple_rule.this_autoscaling_simple_rule_ari, module.target_tracking_rule.this_autoscaling_target_tracking_rule_ari, module.step_rule.this_autoscaling_step_rule_ari]
  scheduled_task_name        = var.scheduled_task_name
  scheduled_task_description = var.scheduled_task_description
  scheduled_task_setting = {
    run_at           = "${local.run_at}T07:15Z"
    retry_interval   = var.retry_interval
    recurrence_type  = var.recurrence_type
    recurrence_value = var.recurrence_value
    end_at           = "${local.end_at}T07:15Z"
  }
  enable_scheduled_task = var.enable_scheduled_task

}
