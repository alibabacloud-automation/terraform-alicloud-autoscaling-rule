output "this_autoscaling_group_id" {
  description = "The id of the autoscaling group"
  value       = alicloud_ess_scaling_group.default.id
}

output "this_autoscaling_simple_rule_id" {
  description = "The id of the autoscaling simple rule"
  value       = module.simple_rule.this_autoscaling_simple_rule_id
}

output "this_autoscaling_simple_rule_ari" {
  description = "The ari of the autoscaling simple rule"
  value       = module.simple_rule.this_autoscaling_simple_rule_ari
}

output "this_autoscaling_simple_rule_name" {
  description = "The name of the autoscaling simple rule"
  value       = module.simple_rule.this_autoscaling_simple_rule_name
}

output "this_autoscaling_target_tracking_rule_id" {
  description = "The id of the autoscaling target tracking rule"
  value       = module.target_tracking_rule.this_autoscaling_target_tracking_rule_id
}

output "this_autoscaling_target_tracking_rule_ari" {
  description = "The ari of the autoscaling target tracking rule"
  value       = module.target_tracking_rule.this_autoscaling_target_tracking_rule_ari
}

output "this_autoscaling_target_tracking_rule_name" {
  description = "The name of the autoscaling target tracking rule"
  value       = module.target_tracking_rule.this_autoscaling_target_tracking_rule_name
}

output "this_autoscaling_step_rule_id" {
  description = "The id of the autoscaling step rule"
  value       = module.step_rule.this_autoscaling_step_rule_id
}

output "this_autoscaling_step_rule_ari" {
  description = "The ari of the autoscaling step rule"
  value       = module.step_rule.this_autoscaling_step_rule_ari
}

output "this_autoscaling_step_rule_name" {
  description = "The name of the autoscaling step rule"
  value       = module.step_rule.this_autoscaling_step_rule_name
}

output "this_autoscaling_alarm_task_name" {
  description = "The name of the autoscaling alarm task"
  value       = module.alarm_task.this_autoscaling_alarm_task_name
}

output "this_autoscaling_alarm_task_id" {
  description = "The id of the autoscaling alarm task"
  value       = module.alarm_task.this_autoscaling_alarm_task_id
}

output "this_autoscaling_scheduled_task_name" {
  description = "The name of the autoscaling scheduled task"
  value       = module.scheduled_task.this_autoscaling_scheduled_task_name
}

output "this_autoscaling_scheduled_task_id" {
  description = "The id of the autoscaling scheduled task"
  value       = module.scheduled_task.this_autoscaling_scheduled_task_id
}