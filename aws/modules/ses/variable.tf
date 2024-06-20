variable "enabled" {
  description = "Determines whether to create SES or not"
  type = bool
  default = true
}

variable "cloudwatch_destination_event" {
  description = "Provide the Dimention name and value for cloudwatch destination."
  type        = map(string)
  default     = {}
}

variable "cname_type" {
  type        = string
  default     = "CNAME"
  description = "CNAME type for Record Set."
}

variable "configuration_set_name" {
  description = "Provide the name for Configuration set."
  type = string
  default = ""
}

variable "custom_redirect_domain" {
  type        = string
  description = "Custom subdomain that is used to redirect email recipients to the Amazon SES event tracking domain"
  default     = ""
}

variable "create_dedicated_ip_pool" {
  description = "Should be true if you want to create dedicated ip pool"
  type        = bool
  default     = false
}

variable "create_receipt_rule_set" {
  description = "Should be true if you wnat to create receipt rule set."
  type = bool
  default = false
}

variable "create_receipt_rule" {
  description = "Should be true if you want to create receipt rule"
  type = bool
  default = false
}

variable "dedicated_ip_pool_name" {
  description = "Provide the name for dedicated ip pool"
  type        = string
  default     = ""
}

variable "domain" {
  description = "Provide the domain name to assign to SES"
  type = string
  default = ""
}

variable "emails" {
  type        = list(string)
  description = "Emails list to use for SES."
  default = []
}

variable "enable_mail_from" {
  type        = bool
  default     = false
  description = "Control whether or not to enable mail from domain."
}

variable "enable_mx" {
  type        = bool
  default     = false
  description = "Control whether or not to enable mx DNS recodrds."
}

variable "lambda_invocation_type" {
  description = "Provide the Invocation type to Invoke Lambda function. Allowed values are Event or RequestResponse"
  type = string
  default = ""
}

variable "mail_from_domain" {
  type        = string
  default     = ""
  description = "Subdomain (of the route53 zone) which is to be used as MAIL FROM address."
}

variable "mx_type" {
  type        = string
  default     = "MX"
  description = "MX type for Record Set."
}

variable "notification_type" {
  description = "The type of notifications that will be published to the specified Amazon SNS topic. Allowed values are Bounce, Complaint or Delivery"
  type = list(string) #set(string)
  default = []
}

variable "receipt_rule_set_name" {
  description = "Provide the name for Receipt rule set"
  type = string
  default = ""
}

variable "receipt_rule_name" {
  description = "Provide the name for Receipt rule."
  type = string
  default = ""
}

variable "recipients" {
  description = "A list of email addresses"
  type        = list(string)
  default     = []
}

variable "s3_store_bucket_name" {
  description = "Provide the nsme of s3 bucket where you want to store emails."
  type = string
  default = ""
}

variable "ses_lambda_function_arn" {
  description = "Provide the ARN of the Lambda function to invoke"
  type = string
  default = ""
}

variable "scaling_mode" {
  description = "Specifies whether the dedicated IP pool is managed or not.The possible values are MANAGED and STANDARD. The default value is STANDARD."
  type = string
  default = "STANDARD"
}

variable "sns_topic_arn" {
 description = "Provide the SNS ARN"
 type = string
 default = ""
}

variable "tls_policy" {
  type        = string
  description = "Whether messages that use the configuration set are required to use Transport Layer Security. The possible values are REQUIRE or OPTIONAL"
  default = ""
}

variable "zone_id" {
  description = "Provide the Zone ID of the Route53 Domain. If Route 53 and SES Present in the same account."
  type = string
  default = ""
}

variable "object_key_prefix" {
  description = "The key prefix of the S3 bucket"
  type = string
  default = ""
}



