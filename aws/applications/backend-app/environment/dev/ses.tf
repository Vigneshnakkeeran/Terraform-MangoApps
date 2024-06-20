module "ses_email" {
  source = "../../../../modules/ses"

 # emails = var.emails
  domain = var.domain
  zone_id = var.zone_id

  ## Email receiving Rule set.
  create_receipt_rule_set  = var.create_receipt_rule_set
  create_receipt_rule   = var.create_receipt_rule 
  receipt_rule_set_name = var.receipt_rule_set_name
  receipt_rule_name = var.receipt_rule_name
  s3_store_bucket_name = module.ses_s3.s3_bucket_id
  object_key_prefix    = var.object_key_prefix

  ses_lambda_function_arn = module.ses_lambda_module.lambda_function_arn
  lambda_invocation_type = var.lambda_invocation_type

  ##Enable Feedback notifications
  sns_topic_arn = module.sns.topic_arn
  notification_type = var.notification_type
  recipients = var.recipients
  
  #provide vale to create configuration set
  configuration_set_name = var.configuration_set_name
  tls_policy = var.tls_policy
  cloudwatch_destination_event = var.cloudwatch_destination_event

  #to create dedicated ip pool
  create_dedicated_ip_pool = var.create_dedicated_ip_pool
  dedicated_ip_pool_name  = var.dedicated_ip_pool_name
}


# #module to create domain identity
# #module "ses_domain" {
# #  source = "./ses"

#  # domain = var.domain
#  # zone_id = var.zone_id

# #  ses_lambda_function_arn = module.my_lambda_module.arn
# #  lambda_invocation_type = var.lambda_invocation_type

# #  ##Enable Feedback notifications
# #  sns_topic_arn = aws_sns_topic.user_updates.arn
# #  notification_type = var.notification_type

# #  recipients = var.recipients
# #}
