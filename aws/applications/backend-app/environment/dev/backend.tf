terraform {
  backend "s3" {
    bucket = "mangoapps-tfbackend-bucket"
    key    = "backend-app/env/dev/terraform.tfstate"
    region = "us-west-2"
    # dynamodb_table = "mangoapps-terraform-backend-db"
  }
}

resource "local_file" "file_output" {
  filename              = "${var.client_name}-${var.environment}-terraform-output.txt"
  file_permission       = "0664"
  directory_permission  = "0755"
  content               = <<-EOT

  [RDS]
  RDS_WRITER_ENDPOINT = ${module.rds.cluster_writer_endpoint}
  RDS_READER_ENDPOINT = ${module.rds.cluster_reader_endpoint}
  RDS_DB_NAME         = ${module.rds.cluster_database_name}
  RDS_PORT            = ${module.rds.cluster_port}

  [SQS]
  SQS_QUEUE_NAME      = ${module.sqs.queue_name}
  SQS_QUEUE_URL       = ${module.sqs.queue_url}

  [SNS]
  SNS_TOPIC_NAME      = ${module.sns.topic_name}
  SNS_TOPIC_ARN       = ${module.sns.topic_arn}  

  [S3]
  S3_BUCKET_NAME      = ${module.s3.s3_bucket_id}
  EOT
}

resource "aws_s3_object" "output_file_upload" {
  depends_on = [local_file.file_output ]
  bucket = "mangoapps-tfbackend-bucket"
  key    = "backend-app/env/dev/outputs/${var.client_name}-${var.environment}-terraform-output.txt"
  source = "./${var.client_name}-${var.environment}-terraform-output.txt"
}