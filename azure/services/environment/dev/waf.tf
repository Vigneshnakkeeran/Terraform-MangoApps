module "waf_policy" {
  source  = "../../../modules/waf"

  policy_name = "${var.client_name}-${var.environment}-waf-policy"
  location       = var.location

  resource_group_name = data.terraform_remote_state.dev_resource_group.outputs.dev_rg

  policy_mode = var.policy_mode

  managed_rule_set_configuration = var.waf_managed_rule_set_configuration

  custom_rules_configuration = var.waf_custom_rules_configuration
}