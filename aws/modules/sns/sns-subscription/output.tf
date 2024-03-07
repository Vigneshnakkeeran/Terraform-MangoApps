################################################################################
# Subscription(s)
################################################################################

output "subscriptions" {
  description = "Map of subscriptions created and their attributes"
  value       = aws_sns_topic_subscription.this
}
