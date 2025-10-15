
variable "scaling_rule_name" {
  description = "(Deprecated from version 1.2.0) The name for scaling rule. Default to a random string prefixed with `terraform-ess-<rule type>-`. Use scaling_simple_rule_name, scaling_target_tracking_rule_name and scaling_step_rule_name instead."
  type        = string
  default     = ""
}

variable "adjustment_type" {
  description = "(Deprecated from version 1.2.0) The method only used by the simple and step scaling rule to adjust the number of ECS instances. Valid values: QuantityChangeInCapacity, PercentChangeInCapacity and TotalCapacity. Use simple_rule_adjustment_type and step_rule_adjustment_type instead."
  type        = string
  default     = "TotalCapacity"
}

variable "estimated_instance_warmup" {
  description = "(Deprecated from version 1.2.0) The warm-up period of the ECS instances. It is applicable to target tracking and step scaling rules. The system adds ECS instances that are in the warm-up state to the scaling group, but does not report monitoring data during the warm-up period to CloudMonitor. Valid values: 0 to 86400. Unit: seconds. Use target_tracking_rule_estimated_instance_warmup and step_rule_estimated_instance_warmup instead."
  type        = number
  default     = 300
}

variable "metric_name" {
  description = "(Deprecated from version 1.2.0) The monitoring index name. Details see `[system monitoring index](https://help.aliyun.com/document_detail/141651.htm)` and `[custom monidoring index](https://www.alibabacloud.com/help/doc-detail/74861.htm)`. Use target_tracking_rule_metric_name instead."
  type        = string
  default     = "CpuUtilization"
}

# Simple rule
variable "create_simple_rule" {
  description = "Whether to create a simple scaling rule in the specified scaling group."
  type        = bool
  default     = false
}

variable "scaling_group_id" {
  description = "Specifying existing autoscaling group ID. If not set, it can be retrieved automatically by specifying filter `scaling_group_name_regex`."
  type        = string
  default     = ""
}

variable "scaling_simple_rule_name" {
  description = "The name for scaling rule. Default to a random string prefixed with `terraform-ess-<rule type>-`."
  type        = string
  default     = ""
}

variable "scaling_group_name_regex" {
  description = "Using a name regex to retrieve existing scaling group automactially."
  type        = string
  default     = ""
}

variable "simple_rule_adjustment_type" {
  description = "The method only used by the simple and step scaling rule to adjust the number of ECS instances. Valid values: QuantityChangeInCapacity, PercentChangeInCapacity and TotalCapacity."
  type        = string
  default     = "TotalCapacity"
}

variable "adjustment_value" {
  description = "The number of ECS instances to be adjusted in the simple scaling rule. The number of ECS instances to be adjusted in a single scaling activity cannot exceed 500."
  type        = number
  default     = 0
}

variable "cooldown" {
  description = "The cooldown time of the simple scaling rule. Valid values: 0 to 86400. Unit: seconds. If not set, the scaling group's cooldown will be used."
  type        = number
  default     = 0
}

# target tracking rule
variable "create_target_tracking_rule" {
  description = "Whether to create a target tracking scaling rule in the specified scaling group."
  type        = bool
  default     = false
}

variable "scaling_target_tracking_rule_name" {
  description = "The name for scaling rule. Default to a random string prefixed with `terraform-ess-<rule type>-`."
  type        = string
  default     = ""
}

variable "target_tracking_rule_estimated_instance_warmup" {
  description = "The warm-up period of the ECS instances. It is applicable to target tracking and step scaling rules. The system adds ECS instances that are in the warm-up state to the scaling group, but does not report monitoring data during the warm-up period to CloudMonitor. Valid values: 0 to 86400. Unit: seconds."
  type        = number
  default     = 300
}

variable "target_tracking_rule_metric_name" {
  description = "The predefined metric to monitor. This parameter is required and applicable only to target tracking scaling rules. See valid values: https://www.alibabacloud.com/help/doc-detail/25948.htm"
  type        = string
  default     = "CpuUtilization"
}

variable "target_value" {
  description = "The target value of a metric. This parameter is required and applicable only to target tracking scaling rules. It must be greater than 0 and can have a maximum of three decimal places."
  type        = string
  default     = "80.5"
}

variable "disable_scale_in" {
  description = "Whether to disable scale-in. This parameter is applicable only to target tracking scaling rules."
  type        = bool
  default     = false
}

# step rule
variable "create_step_rule" {
  description = "Whether to create a step scaling rule in the specified scaling group."
  type        = bool
  default     = false
}

variable "scaling_step_rule_name" {
  description = "The name for scaling rule. Default to a random string prefixed with `terraform-ess-<rule type>-`."
  type        = string
  default     = ""
}

variable "step_rule_adjustment_type" {
  description = "The method only used by the simple and step scaling rule to adjust the number of ECS instances. Valid values: QuantityChangeInCapacity, PercentChangeInCapacity and TotalCapacity."
  type        = string
  default     = "TotalCapacity"
}

variable "step_rule_estimated_instance_warmup" {
  description = "The warm-up period of the ECS instances. It is applicable to target tracking and step scaling rules. The system adds ECS instances that are in the warm-up state to the scaling group, but does not report monitoring data during the warm-up period to CloudMonitor. Valid values: 0 to 86400. Unit: seconds."
  type        = number
  default     = 300
}

variable "step_adjustments" {
  description = "The predefined metric to monitor. This parameter is required and applicable only to step scaling rules. Each item contains the following parameters: `lower_limit`(The lower limit value specified. Valid values: -9.999999E18 to 9.999999E18.), `upper_limit`(The upper limit value specified. Valid values: -9.999999E18 to 9.999999E18.), `adjustment_value`(The specified number of ECS instances to be adjusted)"
  type        = list(map(string))
  default     = []
}

# alarm task
variable "create_alarm_task" {
  description = "If true, the module will create a scheduled task for each scaling rule"
  type        = bool
  default     = false
}

variable "alarm_task_name" {
  description = "The name for alarm task. Default to a random string prefixed with `terraform-alarm-task-`."
  type        = string
  default     = ""
}

variable "alarm_description" {
  description = "The description for the alarm."
  type        = string
  default     = ""
}

variable "enable_alarm_task" {
  description = "Whether to enable the alarm task."
  type        = bool
  default     = true
}

variable "task_actions" {
  description = "The list of actions to execute when this alarm transition into an ALARM state."
  type        = list(string)
  default     = []
}

variable "alarm_task_metric_type" {
  description = "The monitoring type for alarm task. Valid values system, custom. `system` means the metric data is collected by Aliyun Cloud Monitor Service(CMS); `custom` means the metric data is upload to CMS by users."
  type        = string
  default     = "system"
}

variable "alarm_task_metric_name" {
  description = "The monitoring index name. Details see `[system monitoring index](https://help.aliyun.com/document_detail/141651.htm)` and `[custom monidoring index](https://www.alibabacloud.com/help/doc-detail/74861.htm)`."
  type        = string
  default     = "CpuUtilization"
}

variable "alarm_task_setting" {
  description = "The setting of monitoring index setting. It contains the following parameters: `period`(A reference period used to collect, summary, and compute data. Default to 60 seconds), `method`(The method used to statistics data, default to Average), `threshold`(Verify whether the statistics data value of a metric exceeds the specified threshold. Default to 0), `comparison_operator`(The arithmetic operation to use when comparing the specified method and threshold. Default to >=), `trigger_after`(You can select one the following options, such as 1, 2, 3, and 5 times. When the value of a metric exceeds the threshold for specified times, an event is triggered, and the specified scaling rule is applied. Default to 3 times.)"
  type        = map(string)
  default     = {}
}

# scheduled task
variable "create_scheduled_task" {
  description = "If true, the module will create a scheduled task for each scaling rule"
  type        = bool
  default     = false
}

variable "scheduled_task_name" {
  description = "The name for scheduled task. Default to a random string prefixed with `terraform-scheduled-task-`."
  type        = string
  default     = ""
}

variable "scheduled_task_description" {
  description = "Description of the scheduled task, which is 2-200 characters (English or Chinese) long."
  type        = string
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