module "sns" {
  source = "../../../modules/sns"

  name            = "${var.client_name}-${var.environment}-sns"
  use_name_prefix = false
  display_name    = "${var.client_name}-${var.environment}-sns"


  # SQS queue must be FIFO as well
  fifo_topic                  = false
  content_based_deduplication = false

  delivery_policy = jsonencode({
    "http" : {
      "defaultHealthyRetryPolicy" : {
        "minDelayTarget" : 20,
        "maxDelayTarget" : 20,
        "numRetries" : 3,
        "numMaxDelayRetries" : 0,
        "numNoDelayRetries" : 0,
        "numMinDelayRetries" : 0,
        "backoffFunction" : "linear"
      },
      "disableSubscriptionOverrides" : false,
      "defaultThrottlePolicy" : {
        "maxReceivesPerSecond" : 1
      }
    }
  })

  create_subscription = var.create_sqs
        subscriptions = {
    sqs = {
      protocol = "sqs"
      endpoint = module.sqs[0].queue_arn
    }
  }

  tags = {
    CreatedBy   = "Terraform"
    Client      = var.client_name
    Environment = var.environment
  }
}

# SNS Email Subscription
module "sns_additional_subscription" {
	source = "../../../modules/sns/sns-subscription"
	count = var.sns_additional_subscriptions == null ? 0 : 1
	subscriptions = var.sns_additional_subscriptions
	sns_topic_arn = module.sns.topic_arn
}