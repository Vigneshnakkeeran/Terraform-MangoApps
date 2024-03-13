resource "azurerm_web_application_firewall_policy" "waf" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  dynamic "custom_rules" {
    for_each = var.custom_rules

    content {
        enabled = custom_rules.enabled
        name = custom_rules.name
        priority = custom_rules.priority
        rule_type = custom_rules.rule_type

        dynamic "match_conditions" {
          for_each = custom_rules.match_conditions
          
          content {
            dynamic "match_variables" {
              for_each = match_conditions.match_variables

              content {
                variable_name = match_variables.variable_name
                selector = match_variables.selector
              }
            }

          match_values = match_conditions.match_values
          operator = match_conditions.operator
          negation_condition = match_conditions.negation_condition
          transforms = match_conditions.transforms
          }
        }

        action = custom_rules.action
        rate_limit_duration = custom_rules.rate_limit_duration
        rate_limit_threshold = custom_rules.rate_limit_threshold
        group_rate_limit_by = custom_rules.group_rate_limit_by
      }
    }

  policy_settings {
      enabled = var.policy_settings_enabled
      mode = var.policy_settings_mode
      file_upload_limit_in_mb = var.policy_settings_file_upload_limit_in_mb
      request_body_check = var.policy_settings_request_body_check
      max_request_body_size_in_kb = var.policy_settings_max_request_body_size_in_kb
      request_body_inspect_limit_in_kb = var.policy_settings_request_body_inspect_limit_in_kb
  }

  managed_rules {

    dynamic "exclusion" {
      for_each = var.exclusion

      content {
        match_variable = exclusion.match_variable
        selector = exclusion.selector
        selector_match_operator = exclusion.selector_match_operator
        
        dynamic "excluded_rule_set" {
          for_each = exclusion.excluded_rule_set

          content {
            type = excluded_rule_set.type
            version = excluded_rule_set.version

            dynamic "rule_group" {
              for_each = excluded_rule_set.rule_group

              content {
                rule_group_name = rule_group.rule_group_name
                excluded_rules = rule_group.excluded_rules
              }
            }
          }
        }
      }
    }

    dynamic "managed_rule_set" {
      for_each = var.managed_rule_set

      content {
        type = managed_rule_set.type
        version = managed_rule_set.managed_rule_set_version

        dynamic "rule_group_override" {
          for_each = managed_rule_set.rule_group_override

          content {
            rule_group_name = rule_group_override.rule_group_name

            dynamic "rule" {
              for_each = rule_group_override.rule

              content {
                id = rule.id
                enabled = rule.enabled
                action = rule.action
              }
            }
          }
        }
      }
    }
  }
}