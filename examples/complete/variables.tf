variable "scaling_rule_tracking_name" {
  description = "The name for scaling rule. Default to a random string prefixed with `terraform-ess-<rule type>-`."
  type        = string
  default     = "tf-rule-simple-test-003"
}

variable "scaling_rule_step_name" {
  description = "The name for scaling rule. Default to a random string prefixed with `terraform-ess-<rule type>-`."
  type        = string
  default     = "tf-rule-simple-test-004"
}

variable "scaling_rule_simple_name" {
  description = "The name for scaling rule. Default to a random string prefixed with `terraform-ess-<rule type>-`."
  type        = string
  default     = "tf-rule-simple-test-005"
}

variable "adjustment_type" {
  description = "The method only used by the simple and step scaling rule to adjust the number of ECS instances. Valid values: QuantityChangeInCapacity, PercentChangeInCapacity and TotalCapacity."
  type        = string
  default     = "PercentChangeInCapacity"
}

variable "adjustment_value" {
  description = "The number of ECS instances to be adjusted in the simple scaling rule. The number of ECS instances to be adjusted in a single scaling activity cannot exceed 500."
  type        = number
  default     = 200
}

variable "cooldown" {
  description = "The cooldown time of the simple scaling rule. Valid values: 0 to 86400. Unit: seconds. If not set, the scaling group's cooldown will be used."
  type        = string
  default     = 10
}

variable "metric_name" {
  description = "The predefined metric to monitor. This parameter is required and applicable only to target tracking scaling rules. See valid values: https://www.alibabacloud.com/help/doc-detail/25948.htm"
  type        = string
  default     = "CpuUtilization"
}

variable "alarm_task_setting" {
  description = "The setting of monitoring index setting. It contains the following parameters: `period`(A reference period used to collect, summary, and compute data. Default to 60 seconds), `method`(The method used to statistics data, default to Average), `threshold`(Verify whether the statistics data value of a metric exceeds the specified threshold. Default to 0), `comparison_operator`(The arithmetic operation to use when comparing the specified method and threshold. Default to >=), `trigger_after`(You can select one the following options, such as 1, 2, 3, and 5 times. When the value of a metric exceeds the threshold for specified times, an event is triggered, and the specified scaling rule is applied. Default to 3 times.)"
  type        = map(string)
  default     = {"period" : "60", "statistics" : "Average", "threshold" : 200.3, "comparison_operator" : ">=", "evaluation_count" : 2 }
}

variable "scheduled_task_setting" {
  description = "The setting of running a scheduled task. It contains basic and recurrence setting. Deails see `run_at`(the time at which the scheduled task is triggered), `retry_interval`(the time period during which a failed scheduled task is retried, default to 600 seconds), `recurrence_type`(the recurrence type of the scheduled task: Daily, Weekly, Monthly or Cron, default to empty), `recurrence_value`(the recurrence frequency of the scheduled task, it must be set when `recurrence_type` is set) and `end_at`(the end time after which the scheduled task is no longer repeated. it will ignored if `recurrence_type` is not set)"
  type        = map(string)
  default     = {"run_at":"2021-12-29T11:37Z","retry_interval":600,"recurrence_type":"Daily","recurrence_value":30,"end_at":"2022-2-21T11:37:30Z"}
}

variable "enable_scheduled_task" {
  description = "Whether to enable the scheduled task."
  type        = bool
  default     = false
}

variable "step_adjustments"  {
  description = "The predefined metric to monitor. This parameter is required and applicable only to step scaling rules. Each item contains the following parameters: `lower_limit`(The lower limit value specified. Valid values: -9.999999E18 to 9.999999E18.), `upper_limit`(The upper limit value specified. Valid values: -9.999999E18 to 9.999999E18.), `adjustment_value`(The specified number of ECS instances to be adjusted)"
  type        = list(map(string))
  default     = [{"lower_limit":0,"upper_limit":null,"adjustment_value":1}]
}

variable "alarm_task_name" {
  description = "The name for alarm task. Default to a random string prefixed with `terraform-alarm-task-`."
  type        = string
  default     = "tf-test-002"
}

variable "enable_alarm_task"  {
  description = "Whether to enable the alarm task."
  type        = bool
  default     = false
}

variable "disable_scale_in" {
  description = "Whether to disable scale-in. This parameter is applicable only to target tracking scaling rules."
  type        = bool
  default     = false
}
