output "shield_id" {
  description = "Shield IDs"
  value = aws_shield_protection.default.*.id
}

output "shield_arn" {
  description = "Shield ARNs"
  value = aws_shield_protection.default.*.arn
}