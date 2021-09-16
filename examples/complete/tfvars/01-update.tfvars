##############################################################
#variables for alicloud_ess_scaling_rule
##############################################################
scaling_rule_tracking_name  = "tf-rule-simple-test-003-update"
scaling_rule_step_name      = "tf-rule-simple-test-004-update"
scaling_rule_simple_name    = "tf-rule-simple-test-005-update"
adjustment_type             = "QuantityChangeInCapacity"
adjustment_value            = 300
cooldown                    = 100
step_adjustments            = [{"lower_limit":1,"upper_limit":null,"adjustment_value":2}]
disable_scale_in            = true
##############################################################
#variables for alicloud_ess_alarm
##############################################################
metric_name         = "ClassicInternetRx"
alarm_task_setting  = {"statistics" : "Minimum", "threshold" : 400, "comparison_operator" : ">=", "evaluation_count" : 3 }
alarm_task_name     = "tf-test-002-update"
enable_alarm_task   = true
##############################################################
#variables for alicloud_ess_scheduled_task
##############################################################
scheduled_task_setting = {"run_at":"2021-12-30T11:37Z","retry_interval":600,"recurrence_type":"Daily","recurrence_value":31,"end_at":"2022-2-22T11:37:30Z"}
enable_scheduled_task = true