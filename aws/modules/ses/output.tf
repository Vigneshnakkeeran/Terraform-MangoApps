output "ses_receipt_rule_arn" {
  value = aws_ses_receipt_rule.store[0].arn
}