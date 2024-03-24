# WAF Terraform module
module "regional_wafv2_web_acl" {
  source          = "../../../../modules/waf"
  create_wafv2    = var.regional_create_wafv2
  web_acl_name    = "${var.client_name}-${var.environment}-regional-web-acl"
  waf_description = "${var.client_name} ${var.environment} Regional WAF"
  scope                              = "REGIONAL"
  visibility_config                  = var.regional_waf_visibility_config

  # List of AWS managed WAF rule configurations
  managed_rule_group_statement_rules = var.regional_waf_managed_rule_group_statement_rules
  
  # List of resources to which WAF is associated to. (Associated to Cloudfront should done from Cloudfront module)
  association_resource_arns          = [module.nlb.arn]
  
  tags                               = {
    Created_by  = "Terraform"
    Client      = var.client_name
    Environment = var.environment
  }
}

# module "cloudfront_wafv2_web_acl" {
#   source          = "../../../modules/waf"
#   create_wafv2    = var.cloudfront_create_wafv2
#   web_acl_name    = "${var.client_name}-${var.environment}-cloudfront-web-acl"
#   waf_description = "${var.client_name} ${var.environment} Cloudfront WAF"
#   scope                              = "CLOUDFRONT"
#   visibility_config                  = var.cloudfront_waf_visibility_config

#   # List of AWS managed WAF rule configurations
#   managed_rule_group_statement_rules = var.cloudfront_waf_managed_rule_group_statement_rules
  
#   tags                               = {
#     Created_by  = "Terraform"
#     Client      = var.client_name
#     Environment = var.environment
#   }
# }