output "this_autoscaling_group_id" {
  description = "The id of the autoscaling group"
  value       = local.scaling_group_id
}

output "this_autoscaling_simple_rule_id" {
  description = "The id of the autoscaling simple rule"
  value       = concat(alicloud_ess_scaling_rule.simple.*.id, [""])[0]
}
output "this_autoscaling_simple_rule_ari" {
  description = "The ari of the autoscaling simple rule"
  value       = concat(alicloud_ess_scaling_rule.simple.*.ari, [""])[0]
}
output "this_autoscaling_simple_rule_name" {
  description = "The name of the autoscaling simple rule"
  value       = concat(alicloud_ess_scaling_rule.simple.*.id, [""])[0]
}
output "this_autoscaling_target_tracking_rule_id" {
  description = "The id of the autoscaling target tracking rule"
  value       = concat(alicloud_ess_scaling_rule.target-tracking.*.id, [""])[0]
}
output "this_autoscaling_target_tracking_rule_ari" {
  description = "The ari of the autoscaling target tracking rule"
  value       = concat(alicloud_ess_scaling_rule.target-tracking.*.ari, [""])[0]
}
output "this_autoscaling_target_tracking_rule_name" {
  description = "The name of the autoscaling target tracking rule"
  value       = concat(alicloud_ess_scaling_rule.target-tracking.*.ari, [""])[0]
}
output "this_autoscaling_step_rule_id" {
  description = "The id of the autoscaling step rule"
  value       = concat(alicloud_ess_scaling_rule.step.*.id, [""])[0]
}
output "this_autoscaling_step_rule_ari" {
  description = "The ari of the autoscaling step rule"
  value       = concat(alicloud_ess_scaling_rule.step.*.ari, [""])[0]
}
output "this_autoscaling_step_rule_name" {
  description = "The name of the autoscaling step rule"
  value       = concat(alicloud_ess_scaling_rule.step.*.ari, [""])[0]
}
output "this_autoscaling_alarm_task_name" {
  description = "The name of the autoscaling alarm task"
  value       = concat(alicloud_ess_alarm.this.*.name, [""])[0]
}
output "this_autoscaling_alarm_task_id" {
  description = "The id of the autoscaling alarm task"
  value       = concat(alicloud_ess_alarm.this.*.id, [""])[0]
}

output "this_autoscaling_scheduled_task_name" {
  description = "The name of the autoscaling scheduled task"
  value       = concat(alicloud_ess_scheduled_task.this.*.scheduled_task_name, [""])[0]
}

output "this_autoscaling_scheduled_task_id" {
  description = "The id of the autoscaling scheduled task"
  value       = concat(alicloud_ess_scheduled_task.this.*.id, [""])[0]
}