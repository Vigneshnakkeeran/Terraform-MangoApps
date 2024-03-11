module "sqs" {
  source = "../../../modules/sqs"
        count = var.create_sqs ? 1 : 0

  name                        = "${var.client_name}-${var.environment}-sqs"
  fifo_queue                  = var.sqs_create_fifo_queue
  sqs_managed_sse_enabled     = var.sqs_sse_enabled
  content_based_deduplication = var.sqs_create_fifo_queue ? var.enable_content_based_deduplication : null
  max_message_size            = try(var.max_message_size, null) 
  message_retention_seconds   = try(var.message_retention_seconds, null)


  # Create Dead letter queue
  create_dlq = var.sqs_create_dlq
  tags = {
    CreatedBy   = "Terraform"
    Client      = var.client_name
    Environment = var.environment
  }
}