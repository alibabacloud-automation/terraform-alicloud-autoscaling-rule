// A simple scaling rule
scaling_simple_rule_name    = "update-terraform-ess-simple-rule"
simple_rule_adjustment_type = "QuantityChangeInCapacity"
adjustment_value            = 1
cooldown                    = 1

// A target tracking scaling rule
scaling_target_tracking_rule_name              = "update-terraform-ess-target-tracking-rule"
target_tracking_rule_estimated_instance_warmup = 310
target_tracking_rule_metric_name               = "ClassicInternetRx"
target_value                                   = "80.6"
disable_scale_in                               = true

// A step scaling rule
scaling_step_rule_name = "update-terraform-ess-step-rule"
step_adjustments = [
  {
    lower_limit      = 55
    upper_limit      = 65.5
    adjustment_value = 3
  },
  {
    lower_limit      = 65.5
    adjustment_value = 6
  }
]

// A alarm task
alarm_task_name        = "update-terraform-alarm-task"
alarm_description      = "update_alarm_description"
enable_alarm_task      = false
alarm_task_metric_name = "ClassicInternetRx"
alarm_task_setting = {
  method              = "Maximum",
  threshold           = 1,
  comparison_operator = "<=",
  trigger_after : 5
}

// Several scheduled tasks
scheduled_task_name        = "update-terraform-scheduled-task"
scheduled_task_description = "update_scheduled_task_description"

retry_interval        = 600
recurrence_type       = "Daily"
recurrence_value      = "1"
enable_scheduled_task = false