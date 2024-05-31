######################## ASG ##########################

output "autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.asg.autoscaling_group_id
}

output "autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.asg.autoscaling_group_name
}

output "autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.asg.autoscaling_group_arn
}

output "autoscaling_policy_arns" {
  value = {
    scale_down = module.asg.autoscaling_policy_arns["scale_down"]
    scale_up   = module.asg.autoscaling_policy_arns["scale_up"]
  }
}

################################ SNS ###############################
output "sns_cw_topic_arn" {
  description = "The ARN of the SNS topic, as a more obvious property (clone of id)"
  value       = module.cw_asg_alarm_sns_topic.topic_arn
}

output "sns_cw_topic_name" {
  description = "The name of the topic"
  value       = module.cw_asg_alarm_sns_topic.topic_name
}