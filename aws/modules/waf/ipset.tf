locals {
  ip_sets = local.count && var.ip_set_reference_statement_rules != null ? {
    for indx, rule in flatten(var.ip_set_reference_statement_rules) :
    lookup(rule, "name", null) != null ? format("%s-ip-set", rule.name) : format("ip-set-%d", rule.priority)
    => rule.statement.ip_set if try(rule.statement.ip_set, null) != null && try(rule.statement.arn, null) == null
  } : {}

  ip_rule_to_ip_set = local.count && local.ip_set_reference_statement_rules != null ? {
    for name, rule in local.ip_set_reference_statement_rules :
    name => lookup(rule, "name", null) != null ? format("%s-ip-set", rule.name) : format("ip-set-%d", rule.priority)
  } : {}
}

resource "aws_wafv2_ip_set" "default" {
  for_each = local.ip_sets

  name               = var.ipset_name
  description        = lookup(each.value, "description", null)
  scope              = var.scope
  ip_address_version = each.value.ip_address_version
  addresses          = each.value.addresses

  tags = var.tags
}