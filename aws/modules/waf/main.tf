locals {
  count = var.create_wafv2
}

resource "aws_wafv2_web_acl_association" "default" {
  count = local.count && length(var.association_resource_arns) > 0 ? length(var.association_resource_arns) : 0

  resource_arn = var.association_resource_arns[count.index]
  web_acl_arn  = one(aws_wafv2_web_acl.default[*].arn)
}


resource "aws_wafv2_web_acl_logging_configuration" "default" {
  count = local.count && length(var.log_destination_configs) > 0 ? 1 : 0

  resource_arn            = one(aws_wafv2_web_acl.default[*].arn)
  log_destination_configs = var.log_destination_configs

  dynamic "redacted_fields" {
    for_each = var.redacted_fields

    content {
      dynamic "method" {
        for_each = redacted_fields.value.method ? [true] : []
        content {}
      }

      dynamic "query_string" {
        for_each = redacted_fields.value.query_string ? [true] : []
        content {}
      }

      dynamic "uri_path" {
        for_each = redacted_fields.value.uri_path ? [true] : []
        content {}
      }

      dynamic "single_header" {
        for_each = lookup(redacted_fields.value, "single_header", null) != null ? toset(redacted_fields.value.single_header) : []
        content {
          name = single_header.value
        }
      }
    }
  }

  dynamic "logging_filter" {
    for_each = var.logging_filter != null ? [true] : []

    content {
      default_behavior = var.logging_filter.default_behavior

      dynamic "filter" {
        for_each = var.logging_filter.filter

        content {
          behavior    = filter.value.behavior
          requirement = filter.value.requirement

          dynamic "condition" {
            for_each = filter.value.condition

            content {
              dynamic "action_condition" {
                for_each = condition.value.action_condition != null ? [true] : []
                content {
                  action = condition.value.action_condition.action
                }
              }
              dynamic "label_name_condition" {
                for_each = condition.value.label_name_condition != null ? [true] : []
                content {
                  label_name = condition.value.label_name_condition.label_name
                }
              }
            }
          }
        }
      }
    }
  }
}