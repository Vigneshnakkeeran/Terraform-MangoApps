## Azure WAF Policy Terraform Module

This terraform module creates an Azure WAF policy with managed rules as well as custom rules.

## Usage

```shell
module "waf_policy" {
  source  = "path/of/module"

  location       = module.azure_region.location
  resource_group_name = module.rg.resource_group_name

  policy_mode = "Detection"

  managed_rule_set_configuration = [
    {
      type    = "OWASP"
      version = "3.2"
    }
  ]

  custom_rules_configuration = [
    {
      name      = "DenyAll"
      priority  = 1
      rule_type = "MatchRule"
      action    = "Block"

      match_conditions_configuration = [
        {
          match_variable_configuration = [
            {
              variable_name = "RemoteAddr"
              selector      = null
            }
          ]

          match_values = [
            "192.168.1.0/24"
          ]

          operator           = "IPMatch"
          negation_condition = true
          transforms         = null
        }
      ]
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.93.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.93.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_waf"></a> [waf](#module\_waf) | ./modules/waf | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_web_application_firewall_policy.waf_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources) | resource |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_policy_mode"></a> [policy\_mode](#input\_policy\_mode) | Policy Mode | `string` | n/a | yes |
| <a name="input_waf_custom_rules_configuration"></a> [waf\_custom\_rules\_configuration](#input\_waf\_custom\_rules\_configuration) | Custom rule configuration block. | <pre>list(object({<br>    name      = optional(string)<br>    priority  = optional(number)<br>    rule_type = optional(string)<br>    action    = optional(string)<br>    match_conditions_configuration = optional(list(object({<br>      match_variable_configuration = optional(list(object({<br>        variable_name = optional(string)<br>        selector      = optional(string, null)<br>      })))<br>      match_values       = optional(list(string))<br>      operator           = optional(string)<br>      negation_condition = optional(string, null)<br>      transforms         = optional(list(string), null)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_waf_managed_rule_set_configuration"></a> [waf\_managed\_rule\_set\_configuration](#input\_waf\_managed\_rule\_set\_configuration) | Managed rule set configuration. | <pre>list(object({<br>    type    = optional(string, "OWASP")<br>    version = optional(string, "3.2")<br>    rule_group_override_configuration = optional(list(object({<br>      rule_group_name = optional(string, null)<br>      rule = optional(list(object({<br>        id      = string<br>        enabled = optional(bool)<br>        action  = optional(string)<br>      })), [])<br>    })))<br><br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_waf_policy_id"></a> [waf\_policy\_id](#output\_waf\_policy\_id) | Waf Policy ID |