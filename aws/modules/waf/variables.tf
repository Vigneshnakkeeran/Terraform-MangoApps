variable "waf_description" {
  type        = string
  default     = "Managed by Terraform"
  description = "A friendly description of the WebACL."
}
variable "create_wafv2" {
  description = "Choose whether the waf should be created or not"
  type = bool
  default = false
}
variable "default_action" {
  type        = string
  default     = "block"
  description = "Specifies that AWS WAF should allow requests by default. Possible values: `allow`, `block`."
  nullable    = false
  validation {
    condition     = contains(["allow", "block"], var.default_action)
    error_message = "Allowed values: `allow`, `block`."
  }
}
variable "tags" {
    description = "provide tags for the resource"
    type = map(string)
    default = {}
}
variable "web_acl_name" {
    description = "Provide a name for waf"
    type = string
    default = ""
}
variable "ipset_name" {
  description = "Provide name for ipset"
  type = string
  default = ""
}
variable "custom_response_body" {
  type = map(object({
    content      = string
    content_type = string
  }))

  description = "Defines custom response bodies that can be referenced by custom_response actions."
  default     = {}
  nullable    = false
}

variable "scope" {
  type        = string
  default     = "REGIONAL"
  description = <<-DOC
    Specifies whether this is for an AWS CloudFront distribution or for a regional application.
    Possible values are `CLOUDFRONT` or `REGIONAL`.
    To work with CloudFront, you must also specify the region us-east-1 (N. Virginia) on the AWS provider.
  DOC
  nullable    = false
  validation {
    condition     = contains(["CLOUDFRONT", "REGIONAL"], var.scope)
    error_message = "Allowed values: `CLOUDFRONT`, `REGIONAL`."
  }
}

variable "visibility_config" {
  type = object({
    cloudwatch_metrics_enabled = bool
    metric_name                = string
    sampled_requests_enabled   = bool
  })
  description = "Defines and enables Amazon CloudWatch metrics and web request sample collection."
  default = {
    cloudwatch_metrics_enabled = false
    metric_name                = "default_metric"
    sampled_requests_enabled   = false
  }
}

variable "token_domains" {
  type        = list(string)
  description = "Specifies the domains that AWS WAF should accept in a web request token."
  default     = null
}

# Rules
variable "byte_match_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement that defines a string match search for AWS WAF to apply to web requests."
}

variable "geo_allowlist_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to identify a list of allowed countries which should not be blocked by the WAF."
}

variable "geo_match_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to identify web requests based on country of origin."
}

variable "ip_set_reference_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to detect web requests coming from particular IP addresses or address ranges."
}

variable "managed_rule_group_statement_rules" {
  type = list(object({
    name            = string
    priority        = number
    override_action = optional(string)
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement = object({
      name        = string
      vendor_name = string
      version     = optional(string)
      rule_action_override = optional(map(object({
        action = string
        custom_request_handling = optional(object({
          insert_header = object({
            name  = string
            value = string
          })
        }), null)
        custom_response = optional(object({
          response_code = string
          response_header = optional(object({
            name  = string
            value = string
          }), null)
        }), null)
      })), null)
      managed_rule_group_configs = optional(list(object({
        aws_managed_rules_bot_control_rule_set = optional(object({
          inspection_level = string
        }), null)
        aws_managed_rules_atp_rule_set = optional(object({
          enable_regex_in_path = optional(bool)
          login_path           = string
          request_inspection = optional(object({
            payload_type = string
            password_field = object({
              identifier = string
            })
            username_field = object({
              identifier = string
            })
          }), null)
          response_inspection = optional(object({
            body_contains = optional(object({
              success_strings = list(string)
              failure_strings = list(string)
            }), null)
            header = optional(object({
              name           = string
              success_values = list(string)
              failure_values = list(string)
            }), null)
            json = optional(object({

              identifier      = string
              success_strings = list(string)
              failure_strings = list(string)
            }), null)
            status_code = optional(object({
              success_codes = list(string)
              failure_codes = list(string)
            }), null)
          }), null)
        }), null)
      })), null)
    })
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to run the rules that are defined in a managed rule group."
}

variable "rate_based_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rate-based rule tracks the rate of requests for each originating IP address,and triggers the rule action when the rate exceeds a limit that you specify on the number of requests in any 5-minute time span."
}

variable "regex_pattern_set_reference_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to search web request components for matches with regular expressions."
}

variable "regex_match_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to search web request components for a match against a single regular expression."
}

variable "rule_group_reference_statement_rules" {
  type = list(object({
    name            = string
    priority        = number
    override_action = optional(string)
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement = object({
      arn = string
      rule_action_override = optional(map(object({
        action = string
        custom_request_handling = optional(object({
          insert_header = object({
            name  = string
            value = string
          })
        }), null)
        custom_response = optional(object({
          response_code = string
          response_header = optional(object({
            name  = string
            value = string
          }), null)
        }), null)
      })), null)
    })
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to run the rules that are defined in an WAFv2 Rule Group."
}

variable "size_constraint_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement that uses a comparison operator to compare a number of bytes against the size of a request component."
}

variable "sqli_match_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "An SQL injection match condition identifies the part of web requests, such as the URI or the query string, that you want AWS WAF to inspect."
}

variable "xss_match_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement that defines a cross-site scripting (XSS) match search for AWS WAF to apply to web requests."
}

# Logging configuration
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_logging_configuration.html
variable "log_destination_configs" {
  type        = list(string)
  default     = []
  description = "The Amazon Kinesis Data Firehose, CloudWatch Log log group, or S3 bucket Amazon Resource Names (ARNs) that you want to associate with the web ACL"
}

variable "redacted_fields" {
  type = map(object({
    method        = optional(bool, false)
    uri_path      = optional(bool, false)
    query_string  = optional(bool, false)
    single_header = optional(list(string), null)
  }))
  default     = {}
  description = "The parts of the request that you want to keep out of the logs."
}

variable "logging_filter" {
  type = object({
    default_behavior = string
    filter = list(object({
      behavior    = string
      requirement = string
      condition = list(object({
        action_condition = optional(object({
          action = string
        }), null)
        label_name_condition = optional(object({
          label_name = string
        }), null)
      }))
    }))
  })
  default     = null
  description = <<-DOC
    A configuration block that specifies which web requests are kept in the logs and which are dropped.
    You can filter on the rule action and on the web request labels that were applied by matching rules during web ACL evaluation.
  DOC
}

# Association resource ARNs
variable "association_resource_arns" {
  type        = list(string)
  default     = []
  description = "Provide list of arn's to associate with"
}

variable "default_block_response" {
  type        = string
  default     = null
  description = <<-DOC
    A HTTP response code that is sent when default block action is used. Only takes effect if default_action is set to `block`.
  DOC
  nullable    = true
}