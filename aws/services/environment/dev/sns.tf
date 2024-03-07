module "complete_sns" {
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

  subscriptions = {
    sqs = {
      protocol = "sqs"
      endpoint = "${module.sqs.queue_arn}"

    }
  }

  tags = {
    CreatedBy   = "Terraform"
    Client      = var.client_name
    Environment = var.environment
  }
}
