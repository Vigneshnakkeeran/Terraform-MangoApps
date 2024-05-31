output "cloudwatch_metric_alarm_arns" {
  description = "The Amazon Resource Name (ARN) of the CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.this[*].arn
}

output "cloudwatch_metric_alarm_ids" {
  description = "The ID of the CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.this[*].alarm_name
}
