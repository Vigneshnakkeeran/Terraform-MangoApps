variable "subscriptions" {
  description = "A map of subscription definitions to create"
  type        = any
  default     = {}
}

variable "sns_topic_arn" {
	description = "ARN of the SNS Topic to which the subscription is added."
	type = string
}