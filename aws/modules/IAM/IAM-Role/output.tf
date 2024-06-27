output "role_arn" {
  description = "The ARN of the IAM role."
  value       = aws_iam_role.this.arn
}

output "custom_policy_arn" {
  description = "The ARN of the custom IAM policy."
  value       = aws_iam_policy.custom.arn
}
