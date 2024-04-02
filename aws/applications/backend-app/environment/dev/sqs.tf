module "sqs_income" {
  source = "../../../../modules/sqs"
        count = var.create_sqs ? 1 : 0

  name                        = "mail-${var.client_name}-income"
  fifo_queue                  = var.sqs_create_fifo_queue
  sqs_managed_sse_enabled     = var.sqs_sse_enabled
  content_based_deduplication = var.sqs_create_fifo_queue ? var.enable_content_based_deduplication : null
  max_message_size            = try(var.max_message_size, null) 
  message_retention_seconds   = try(var.message_retention_seconds, null)
  visibility_timeout_seconds  = 160  

  create_queue_policy = true
  queue_policy_statements =  {
    permission1 = {
      sid = "Stmt16366243171311"
      actions = [
        "sqs:*"
      ]
      principals = [
        {
          type        = "*"
          identifiers = ["*"]
        }
      ]
      resources = ["*"]
    }
    permission2 = {
      sid = "__owner_statement"
      actions = [
        "sqs:*"
      ]
      principals = [
        {
          type        = "AWS"
          identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
        }
      ]
    }
    permission3 = {
      sid = "__owner_statement02"
      actions = [
        "sqs:*"
      ]
      principals = [
        {
          type        = "AWS"
          identifiers = ["*"]
        }
      ]
      conditions = [{
        test     = "StringLike"
        variable = "aws:SourceArn"
        values   = [module.sns.topic_arn]
      }]
    }
  }

  # Create Dead letter queue
  create_dlq = var.sqs_create_dlq
  tags = {
    CreatedBy   = "Terraform"
    Client      = var.client_name
    Environment = var.environment
  }
}


module "sqs_feedback" {
  source = "../../../../modules/sqs"
  count = var.create_sqs ? 1 : 0

  name                        = "mail-${var.client_name}-feedback"
  fifo_queue                  = var.sqs_create_fifo_queue
  sqs_managed_sse_enabled     = var.sqs_sse_enabled
  content_based_deduplication = var.sqs_create_fifo_queue ? var.enable_content_based_deduplication : null
  max_message_size            = try(var.max_message_size, null) 
  message_retention_seconds   = try(var.message_retention_seconds, null)
  visibility_timeout_seconds  = 2

  create_queue_policy = true
  queue_policy_statements = {
    permission1 = {
      sid = "Stmt16366243171311"
      actions = [
        "sqs:*"
      ]
      principals = [
        {
          type        = "*"
          identifiers = ["*"]
        }
      ]
      resources = ["*"]
    }
    permission2 = {
      sid = "__owner_statement"
      actions = [
        "sqs:*"
      ]
      principals = [
        {
          type        = "AWS"
          identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
        }
      ]
    }
    permission3 = {
      sid = "__owner_statement02"
      actions = [
        "sqs:*"
      ]
      principals = [
        {
          type        = "AWS"
          identifiers = ["*"]
        }
      ]
      conditions = [{
        test     = "StringLike"
        variable = "aws:SourceArn"
        values   = [module.sns.topic_arn]
      }]
    }
  }


  # Create Dead letter queue
  create_dlq = var.sqs_create_dlq
  tags = {
    CreatedBy   = "Terraform"
    Client      = var.client_name
    Environment = var.environment
  }
}
