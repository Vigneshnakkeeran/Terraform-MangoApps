data "aws_region" "current" {}

locals {
  # some ses resources don't allow for the terminating '.' in the domain name
  stripped_mail_from_domain = replace(var.mail_from_domain, "/[.]$/", "")
  enable_domain             = var.enabled && var.domain != "" ? true : false
  enable_email              = var.enabled && var.emails != [] ? true : false
}


resource "aws_ses_domain_identity" "default" {
  count  = var.enabled && local.enable_domain ? 1 : 0
  domain = var.domain
}

resource "aws_ses_email_identity" "default" {
  count = var.enabled && local.enable_email ? length(var.emails) : 0
  email = var.emails[count.index]
}


resource "aws_ses_domain_dkim" "default" {
  count  = var.enabled && local.enable_domain ? 1 : 0
  domain = aws_ses_domain_identity.default[0].domain
}
 
resource "aws_route53_record" "dkim" {
  count = var.enabled && local.enable_domain && var.zone_id != "" ? 3 : 0

  zone_id = var.zone_id
  name    = format("%s._domainkey.%s", element(aws_ses_domain_dkim.default[0].dkim_tokens, count.index), var.domain)
  type    = var.cname_type
  ttl     = 600
  records = [format("%s.dkim.amazonses.com", element(aws_ses_domain_dkim.default[0].dkim_tokens, count.index))]
}

###SES MAIL FROM DOMAIN#######

#Module      : DOMAIN MAIL FROM
#Description : Terraform module to create domain mail from on AWS
resource "aws_ses_domain_mail_from" "default" {
  count = local.enable_domain && var.enabled && var.enable_mail_from ? 1 : 0

  domain           = aws_ses_domain_identity.default[count.index].domain
  mail_from_domain = local.stripped_mail_from_domain
}

###Sending MX Record#######
#Description : Terraform module to create record of MX for domain mail from
resource "aws_route53_record" "mx_send_mail_from" {
  count = var.enabled && var.zone_id != "" && var.enable_mail_from ? 1 : 0

  zone_id = var.zone_id
  name    = aws_ses_domain_mail_from.default[count.index].mail_from_domain
  type    = var.mx_type
  ttl     = "600"
  records = [format("10 feedback-smtp.%s.amazonses.com", data.aws_region.current.name)]
}

###Receiving MX Record#######
###Description : Terraform module to create record of MX for receipt
resource "aws_route53_record" "mx_receive" {
  count = var.enabled && var.enable_mx && var.zone_id != "" ? 1 : 0

  zone_id = var.zone_id
  name    = "test"
  type    = var.mx_type
  ttl     = "600"
  records = [format("10 inbound-smtp.%s.amazonaws.com", data.aws_region.current.name)]
}

resource "aws_sesv2_configuration_set" "example" {
  count = var.enabled && var.configuration_set_name != "" ? 1 : 0
  configuration_set_name = var.configuration_set_name

  delivery_options {
    tls_policy = var.tls_policy
    sending_pool_name = aws_sesv2_dedicated_ip_pool.example[0].pool_name
  }

  reputation_options {
    reputation_metrics_enabled = true
  }

  sending_options {
    sending_enabled = true
  }
}

resource "aws_ses_event_destination" "cloudwatch" {
  count = var.enabled && var.configuration_set_name != "" ? 1 : 0
  name                   = "email_delivery_details"
  configuration_set_name = aws_sesv2_configuration_set.example[0].configuration_set_name
  enabled                = true
  matching_types         = ["bounce", "send", "reject", "complaint", "delivery", "open", "click", "renderingFailure"]

  dynamic "cloudwatch_destination" {
    for_each = var.cloudwatch_destination_event

    content {
      default_value  = "NONE"
      dimension_name = cloudwatch_destination.key
      value_source   = cloudwatch_destination.value
    }
  }
}

resource "aws_sesv2_dedicated_ip_pool" "example" {
  count = var.enabled && var.create_dedicated_ip_pool ? 1 : 0
  pool_name    = var.dedicated_ip_pool_name
  scaling_mode = var.scaling_mode
}

# resource "aws_sesv2_dedicated_ip_assignment" "test" {
#   ip                    = "0.0.0.0"
#   destination_pool_name = aws_sesv2_dedicated_ip_pool.example.pool_name
# }

resource "aws_ses_receipt_rule_set" "main" {
  count  = var.enabled && var.create_receipt_rule_set ? 1 : 0
  rule_set_name = var.receipt_rule_set_name
}

# store email in S3 and lambda trigger
resource "aws_ses_receipt_rule" "store" {
  count = var.enabled && var.create_receipt_rule ? 1 : 0 
  name          = var.receipt_rule_name
  rule_set_name = aws_ses_receipt_rule_set.main[0].rule_set_name
  recipients    = var.recipients
  enabled       = true
  scan_enabled  = true

  s3_action {
    bucket_name = var.s3_store_bucket_name
    position    = 1
  }

  # lambda_action {
  #   function_arn = var.ses_lambda_function_arn
  #   invocation_type = var.lambda_invocation_type
  #   position = 2
  # }
}

resource "aws_ses_active_receipt_rule_set" "main" {
  count  = var.enabled && var.create_receipt_rule_set ? 1 : 0
  rule_set_name = aws_ses_receipt_rule_set.main[0].rule_set_name
}

# resource "aws_ses_identity_notification_topic" "domain" {
#   # for_each = var.notification_type
#   for_each = { for k, v in  var.notification_type : k => v if local.enable_domain }
#   topic_arn                = var.sns_topic_arn#aws_sns_topic.example.arn
#   notification_type        = each.value
#   identity                 = aws_ses_domain_identity.default[0].domain
#   include_original_headers = false  
# }

resource "aws_ses_identity_notification_topic" "domain" {
  count = local.enable_domain && length(aws_ses_domain_identity.default) > 0 ? length(var.notification_type) : 0

  topic_arn                = var.sns_topic_arn
  notification_type        = var.notification_type[count.index]
  identity                 = length(aws_ses_domain_identity.default) > 0 ? aws_ses_domain_identity.default[0].domain : null
  include_original_headers = false
}

resource "aws_ses_identity_notification_topic" "email" {
  count = local.enable_email && length(aws_ses_email_identity.default) > 0 ? length(var.notification_type) : 0

  topic_arn                = var.sns_topic_arn
  notification_type        = var.notification_type[count.index]
  identity                 = length(aws_ses_email_identity.default) > 0 ? aws_ses_email_identity.default[0].email : null
  include_original_headers = false
}