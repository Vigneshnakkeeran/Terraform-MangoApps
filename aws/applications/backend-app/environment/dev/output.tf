######################## VPC ##########################

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

######################## S3 ##########################

output "s3_bucket_name" {
  description = "The name of the bucket."
  value       = module.s3.s3_bucket_id
}

output "ses_s3_bucket_name" {
  description = "The name of the bucket."
  value       = module.ses_s3.s3_bucket_id
}
#output "s3_bucket_arn" {
#  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
#  value       = module.s3_bucket.s3_bucket_arn
#}

#output "s3_bucket_bucket_domain_name" {
#  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
#  value       = module.s3_bucket.s3_bucket_bucket_domain_name
#}

# ######################## ASG ##########################

output "autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.asg.autoscaling_group_id
}

output "autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.asg.autoscaling_group_name
}

output "autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.asg.autoscaling_group_arn
}

########################## RDS ##########################

output "rds_cluster_writer_endpoint" {
  description = "Writer endpoint for the cluster"
  value       = module.rds.cluster_writer_endpoint
}

output "rds_cluster_reader_endpoint" {
  description = "A read-only endpoint for the cluster, automatically load-balanced across replicas"
  value       = module.rds.cluster_reader_endpoint
}

output "rds_db_name" {
  description =  "Name for an automatically created database on cluster creation"
  value = module.rds.cluster_database_name
}

output "rds_cluster_port" {
  description = "The database port"
  value       = module.rds.cluster_port
}

# ####################### SNS ###########################

output "topic_arn" {
  description = "The ARN of the SNS topic, as a more obvious property (clone of id)"
  value       = module.sns.topic_arn
}

output "topic_name" {
  description = "The name of the topic"
  value       = module.sns.topic_name
}

######################## SQS ##############################
output "queue_id" {
  description = "The URL for the created Amazon SQS queue"
  value       = module.sqs.queue_id
}

output "queue_arn" {
  description = "The ARN of the SQS queue"
  value       = module.sqs.queue_arn
}

output "queue_url" {
  description = "Same as `queue_id`: The URL for the created Amazon SQS queue"
  value       = module.sqs.queue_url
}

output "queue_name" {
  description = "The name of the SQS queue"
  value       = module.sqs.queue_name
}

# ###################### Dead Letter Queue ###########################

# output "dead_letter_queue_id" {
#   description = "The URL for the created Amazon SQS queue"
#   value       = try(aws_sqs_queue.dlq[0].id, null)
# }

# output "dead_letter_queue_arn" {
#   description = "The ARN of the SQS queue"
#   value       = try(aws_sqs_queue.dlq[0].arn, null)
# }

# output "dead_letter_queue_url" {
#   description = "Same as `dead_letter_queue_id`: The URL for the created Amazon SQS queue"
#   value       = try(aws_sqs_queue.dlq[0].url, null)
# }

# output "dead_letter_queue_name" {
#   description = "The name of the SQS queue"
#   value       = try(aws_sqs_queue.dlq[0].name, null)
# }

############## lambda role arn #################

# output "lambda_execution_role" {
#   description = "The ARN of the IAM role created for Lambda execution"
#   value       = module.lambda_execution_role.arn
# }

# output "lambda_arn" {
#  description = "The ARN of the Lambda function"
#  value       = module.my_lambda.arn
# }

####################### WAF #######################

output "regional_waf_id" {
  description = "ID of Reginal WAF"
  value = module.regional_wafv2_web_acl.id
}

output "regional_waf_arn" {
  description = "ARN of Regional WAF"
  value = module.regional_wafv2_web_acl.arn
}

output "cloudfront_waf_id" {
  description = "ID of Reginal WAF"
  value = module.cloudfront_wafv2_web_acl.id
}

output "cloudfront_waf_arn" {
  description = "ARN of Regional WAF"
  value = module.cloudfront_wafv2_web_acl.arn
}

####################### Cloudtrail #######################

output "cloudtrail_id" {
  value       = module.cloudtrail.cloudtrail_id
  description = "The name of the trail"
}

output "cloudtrail_arn" {
  value       = module.cloudtrail.cloudtrail_arn
  description = "The Amazon Resource Name of the trail"
}

####################### Shield #######################

output "shield_id" {
  description = "Shield IDs"
  value = module.aws_shield.shield_id
}

output "shield_arn" {
  description = "Shield ARNs"
  value = module.aws_shield.shield_arn
}
