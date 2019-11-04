output "this_autoscaling_group_id" {
  description = "The id of the autoscaling group"
  value       = local.scaling_group_id
}
output "this_autoscaling_simple_rule_id" {
  description = "The id of the autoscaling simple rule"
  value       = alicloud_ess_scaling_rule.simple.0.id
}
output "this_autoscaling_simple_rule_ari" {
  description = "The ari of the autoscaling simple rule"
  value       = alicloud_ess_scaling_rule.simple.0.ari
}
output "this_autoscaling_simple_rule_name" {
  description = "The name of the autoscaling simple rule"
  value       = alicloud_ess_scaling_rule.simple.0.id
}
output "this_autoscaling_target_tracking_rule_id" {
  description = "The id of the autoscaling target tracking rule"
  value       = alicloud_ess_scaling_rule.target-tracking.0.id
}
output "this_autoscaling_target_tracking_rule_ari" {
  description = "The ari of the autoscaling target tracking rule"
  value       = alicloud_ess_scaling_rule.target-tracking.0.ari
}
output "this_autoscaling_target_tracking_rule_name" {
  description = "The name of the autoscaling target tracking rule"
  value       = alicloud_ess_scaling_rule.target-tracking.0.ari
}
output "this_autoscaling_step_rule_id" {
  description = "The id of the autoscaling step rule"
  value       = alicloud_ess_scaling_rule.step.0.id
}
output "this_autoscaling_step_rule_ari" {
  description = "The ari of the autoscaling step rule"
  value       = alicloud_ess_scaling_rule.step.0.ari
}
output "this_autoscaling_step_rule_name" {
  description = "The name of the autoscaling step rule"
  value       = alicloud_ess_scaling_rule.step.0.ari
}
output "this_autoscaling_alarm_task_name" {
  description = "The name of the autoscaling alarm task"
  value       = alicloud_ess_alarm.this.0.name
}
output "this_autoscaling_alarm_task_id" {
  description = "The id of the autoscaling alarm task"
  value       = alicloud_ess_alarm.this.0.id
}

output "this_autoscaling_scheduled_task_name" {
  description = "The name of the autoscaling scheduled task"
  value       = alicloud_ess_scheduled_task.this.0.scheduled_task_name
}

output "this_autoscaling_scheduled_task_id" {
  description = "The id of the autoscaling scheduled task"
  value       = alicloud_ess_scheduled_task.this.0.id
}