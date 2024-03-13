module "waf_policy" {
  source = "../../../modules/waf"

  name = "${var.client_name}-${var.environment}-waf-policy"
  resource_group_name      = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
  location            = var.location

  custom_rules = var.waf_custom_rules

  policy_settings_enabled = var.waf_policy_settings_enabled
  policy_settings_mode = var.waf_policy_settings_mode
  policy_settings_file_upload_limit_in_mb = var.waf_policy_settings_file_upload_limit_in_mb
  policy_settings_request_body_check = var.waf_policy_settings_request_body_check
  policy_settings_max_request_body_size_in_kb = var.waf_policy_settings_max_request_body_size_in_kb

  exclusion = var.waf_managed_rules_exclusion
  managed_rule_set = var.waf_managed_rule_set
}