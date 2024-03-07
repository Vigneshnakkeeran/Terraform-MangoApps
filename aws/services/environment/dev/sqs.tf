
data "aws_caller_identity" "current" {}

module "sqs" {
  source = "../../../modules/sqs"

  name                    = "${var.client_name}-${var.environment}-sqs"
  fifo_queue              = var.sqs_create_fifo_queue
  sqs_managed_sse_enabled = var.sqs_sse_enabled

  # Dead letter queue
  create_dlq = var.sqs_create_dlq
  redrive_policy = {
    # default is 5 for this module
    maxReceiveCount = 10
  }

  tags = {
    CreatedBy   = "Terraform"
    Client      = var.client_name
    Environment = var.environment
  }
}
