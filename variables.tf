//Autoscaling group
variable "region" {
  description = "The region ID used to launch this module resources. If not set, it will be sourced from followed by ALICLOUD_REGION environment variable and profile."
  default     = ""
}

variable "profile" {
  description = "The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  default     = ""
}
variable "shared_credentials_file" {
  description = "This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  default     = ""
}

variable "skip_region_validation" {
  description = "Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  default     = false
}

variable "scaling_group_id" {
  description = "Specifying existing autoscaling group ID. If not set, it can be retrieved automatically by specifying filter `scaling_group_name_regex`."
  default     = ""
}
variable "scaling_group_name_regex" {
  description = "Using a name regex to retrieve existing scaling group automactially."
  default     = ""
}
variable "scaling_rule_name" {
  description = "The name for scaling rule. Default to a random string prefixed with `terraform-ess-<rule type>-`."
  default     = ""
}
// Simple rule
variable "create_simple_rule" {
  description = "Whether to create a simple scaling rule in the specified scaling group."
  type        = bool
  default     = false
}
variable "adjustment_type" {
  description = "The method only used by the simple and step scaling rule to adjust the number of ECS instances. Valid values: QuantityChangeInCapacity, PercentChangeInCapacity and TotalCapacity."
  default     = "TotalCapacity"
}
variable "adjustment_value" {
  description = "The number of ECS instances to be adjusted in the simple scaling rule. The number of ECS instances to be adjusted in a single scaling activity cannot exceed 500."
  default     = 0
}
variable "cooldown" {
  description = "The cooldown time of the simple scaling rule. Valid values: 0 to 86400. Unit: seconds. If not set, the scaling group's cooldown will be used."
  default     = ""
}
// target tracking rule
variable "create_target_tracking_rule" {
  description = "Whether to create a target tracking scaling rule in the specified scaling group."
  type        = bool
  default     = false
}
variable "metric_name" {
  description = "The predefined metric to monitor. This parameter is required and applicable only to target tracking scaling rules. See valid values: https://www.alibabacloud.com/help/doc-detail/25948.htm"
  default     = "CpuUtilization"
}
variable "target_value" {
  description = "The target value of a metric. This parameter is required and applicable only to target tracking scaling rules. It must be greater than 0 and can have a maximum of three decimal places."
  default     = "80.5"
}
variable "disable_scale_in" {
  description = "Whether to disable scale-in. This parameter is applicable only to target tracking scaling rules."
  type        = bool
  default     = false
}
variable "estimated_instance_warmup" {
  description = "The warm-up period of the ECS instances. It is applicable to target tracking and step scaling rules. The system adds ECS instances that are in the warm-up state to the scaling group, but does not report monitoring data during the warm-up period to CloudMonitor. Valid values: 0 to 86400. Unit: seconds."
  default     = 300
}

// step rule
variable "create_step_rule" {
  description = "Whether to create a step scaling rule in the specified scaling group."
  type        = bool
  default     = false
}
variable "step_adjustments" {
  description = "The predefined metric to monitor. This parameter is required and applicable only to step scaling rules. Each item contains the following parameters: `lower_limit`(The lower limit value specified. Valid values: -9.999999E18 to 9.999999E18.), `upper_limit`(The upper limit value specified. Valid values: -9.999999E18 to 9.999999E18.), `adjustment_value`(The specified number of ECS instances to be adjusted)"
  type        = list(map(string))
  default     = []
}

// alarm task
variable "create_alarm_task" {
  description = "If true, the module will create a scheduled task for each scaling rule"
  type        = bool
  default     = false
}
variable "alarm_task_name" {
  description = "The name for alarm task. Default to a random string prefixed with `terraform-alarm-task-`."
  default     = ""
}
variable "alarm_task_metric_type" {
  description = "The monitoring type for alarm task. Valid values system, custom. `system` means the metric data is collected by Aliyun Cloud Monitor Service(CMS); `custom` means the metric data is upload to CMS by users."
  default     = "system"
}
variable "alarm_task_metric_name" {
  description = "The monitoring index name. Details see `[system monitoring index](https://help.aliyun.com/document_detail/141651.htm)` and `[custom monidoring index](https://www.alibabacloud.com/help/doc-detail/74861.htm)`."
  default     = "CpuUtilization"
}
variable "alarm_task_setting" {
  description = "The setting of monitoring index setting. It contains the following parameters: `period`(A reference period used to collect, summary, and compute data. Default to 60 seconds), `method`(The method used to statistics data, default to Average), `threshold`(Verify whether the statistics data value of a metric exceeds the specified threshold. Default to 0), `comparison_operator`(The arithmetic operation to use when comparing the specified method and threshold. Default to >=), `trigger_after`(You can select one the following options, such as 1, 2, 3, and 5 times. When the value of a metric exceeds the threshold for specified times, an event is triggered, and the specified scaling rule is applied. Default to 3 times.)"
  type        = map(string)
  default     = {}
}
variable "enable_alarm_task" {
  description = "Whether to enable the alarm task."
  type        = bool
  default     = true
}

// scheduled task
variable "create_scheduled_task" {
  description = "If true, the module will create a scheduled task for each scaling rule"
  type        = bool
  default     = false
}
variable "scheduled_task_name" {
  description = "The name for scheduled task. Default to a random string prefixed with `terraform-scheduled-task-`."
  default     = ""
}
variable "scheduled_task_setting" {
  description = "The setting of running a scheduled task. It contains basic and recurrence setting. Deails see `run_at`(the time at which the scheduled task is triggered), `retry_interval`(the time period during which a failed scheduled task is retried, default to 600 seconds), `recurrence_type`(the recurrence type of the scheduled task: Daily, Weekly, Monthly or Cron, default to empty), `recurrence_value`(the recurrence frequency of the scheduled task, it must be set when `recurrence_type` is set) and `end_at`(the end time after which the scheduled task is no longer repeated. it will ignored if `recurrence_type` is not set)"
  type        = map(string)
  default     = {}
}
variable "enable_scheduled_task" {
  description = "Whether to enable the scheduled task."
  type        = bool
  default     = true
}
