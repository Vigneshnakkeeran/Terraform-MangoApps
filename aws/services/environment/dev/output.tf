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


# ####################### SNS ###########################

# output "topic_arn" {
#   description = "The ARN of the SNS topic, as a more obvious property (clone of id)"
#   value       = try(aws_sns_topic.this[0].arn, null)
# }

# output "topic_name" {
#   description = "The name of the topic"
#   value       = try(aws_sns_topic.this[0].name, null)
# }

# output "subscriptions" {
#   description = "Map of subscriptions created and their attributes"
#   value       = aws_sns_topic_subscription.this
# }

# ######################## SQS ##############################
# output "queue_id" {
#   description = "The URL for the created Amazon SQS queue"
#   value       = try(aws_sqs_queue.this[0].id, null)
# }

# output "queue_arn" {
#   description = "The ARN of the SQS queue"
#   value       = try(aws_sqs_queue.this[0].arn, null)
# }

# output "queue_url" {
#   description = "Same as `queue_id`: The URL for the created Amazon SQS queue"
#   value       = try(aws_sqs_queue.this[0].url, null)
# }

# output "queue_name" {
#   description = "The name of the SQS queue"
#   value       = try(aws_sqs_queue.this[0].name, null)
# }

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