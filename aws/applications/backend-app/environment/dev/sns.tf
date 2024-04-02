module "sns" {
  source = "../../../../modules/sns"

  name            = "${var.client_name}-${var.environment}-sns"
  use_name_prefix = false
  display_name    = "${var.client_name}-${var.environment}-sns"


  # SQS queue must be FIFO as well
  fifo_topic                  = false
  content_based_deduplication = false

  topic_policy_statements = {
    permission1 = {
      actions = [
        "SNS:Publish"
      ]

      principals = [{
        type        = "Service"
        identifiers = ["ses.amazonaws.com"]
      }]

      conditions = [{
        test     = "StringEquals"
        variable = "AWS:SourceAccount"
        values   = ["${data.aws_caller_identity.current.account_id}"]
      },
	  {
        test     = "StringLike"
        variable = "AWS:SourceArn"
        values   = ["arn:aws:ses:*"]
      }
	  ]
    }
  }

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
      endpoint = module.sqs_feedback[0].queue_arn
    }
  }

  tags = {
    CreatedBy   = "Terraform"
    Client      = var.client_name
    Environment = var.environment
  }
}

# SNS Email Subscription
module "sns_email_subscription" {
	source = "../../../../modules/sns/sns-subscription"
	count = var.sns_email_subscriptions == null ? 0 : 1
	subscriptions = var.sns_email_subscriptions
	sns_topic_arn = module.sns.topic_arn
}


# module "sns_for_ses" {
#   source = "../../../../modules/sns"

#   name            = "${var.client_name}-${var.environment}-ses-sns"
#   use_name_prefix = false
#   display_name    = "${var.client_name}-${var.environment}-ses-sns"


#   # SQS queue must be FIFO as well
#   fifo_topic                  = false
#   content_based_deduplication = false

#   delivery_policy = jsonencode({
#     "http" : {
#       "defaultHealthyRetryPolicy" : {
#         "minDelayTarget" : 20,
#         "maxDelayTarget" : 20,
#         "numRetries" : 3,
#         "numMaxDelayRetries" : 0,
#         "numNoDelayRetries" : 0,
#         "numMinDelayRetries" : 0,
#         "backoffFunction" : "linear"
#       },
#       "disableSubscriptionOverrides" : false,
#       "defaultThrottlePolicy" : {
#         "maxReceivesPerSecond" : 1
#       }
#     }
#   })

#   tags = {
#     CreatedBy   = "Terraform"
#     Client      = var.client_name
#     Environment = var.environment
#   }
# }
