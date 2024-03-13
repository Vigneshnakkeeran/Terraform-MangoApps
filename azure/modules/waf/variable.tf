variable "name" {
  description = "The name of the policy."
  type = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type = string
}

variable "location" {
  description = "Resource location."
  type = string
}

variable "custom_rules" {
  description = "One or more custom_rules blocks"
  type = list(object({
    enabled             = bool
    name                = string
    priority            = number
    rule_type           = string
    match_conditions    = list(object({
      match_values        = list(string)
      operator            = string
      negation_condition  = string
      transforms          = list(string)
      match_variables     = list(object({
        variable_name       = string
        selector            = string
      }))
    }))
    action              = string
    rate_limit_duration = string
    rate_limit_threshold = number
    group_rate_limit_by = string
  }))
  default = null
}

variable "policy_settings_enabled" {
  description = "Describes if the policy is in enabled state or disabled state."
  type = bool
  default = true
}

variable "policy_settings_mode" {
  description = "Describes if it is in detection mode or prevention mode at the policy level. Valid values are Detection and Prevention"
  type = string
  default = "Prevention"
}

variable "policy_settings_file_upload_limit_in_mb" {
  description = "The File Upload Limit in MB. Accepted values are in the range 1 to 4000"
  type = number
  default = 100
}

variable "policy_settings_request_body_check" {
  description = " Is Request Body Inspection enabled"
  type = bool
  default = true
}

variable "policy_settings_max_request_body_size_in_kb" {
  description = "The Maximum Request Body Size in KB. Accepted values are in the range 8 to 2000"
  type = number
  default = 128
}

variable "policy_settings_request_body_inspect_limit_in_kb" {
  description = "Specifies the maximum request body inspection limit in KB for the Web Application Firewall."
  type = number
  default = 128
}

variable "exclusion" {
  description = "One or more exclusion block"
  type = list(object({
    match_variable            = string
    selector                  = string
    selector_match_operator   = string
    excluded_rule_set         = list(object({
      type                     = string
      version                  = string
      rule_group               = list(object({
        rule_group_name         = string
        excluded_rules          = list(string)
      }))
    }))
  }))
  default = null
}

variable "managed_rule_set" {
  description = "One or more managed_rule_set block"
  type = list(object({
    type                = string
    managed_rule_set_version = string
    rule_group_override = list(object({
      rule_group_name = string
      rule            = list(object({
        id      = string
        enabled = bool
        action  = string
      }))
    }))
  }))
  default = null
}