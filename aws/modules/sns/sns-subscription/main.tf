################################################################################
# Subscription(s)
################################################################################


resource "aws_sns_topic_subscription" "this" {
  for_each = { for k, v in var.subscriptions : k => v }

  confirmation_timeout_in_minutes = try(each.value.confirmation_timeout_in_minutes, null)
  delivery_policy                 = try(each.value.delivery_policy, null)
  endpoint                        = each.value.endpoint
  endpoint_auto_confirms          = try(each.value.endpoint_auto_confirms, null)
  filter_policy                   = try(each.value.filter_policy, null)
  filter_policy_scope             = try(each.value.filter_policy_scope, null)
  protocol                        = each.value.protocol
  raw_message_delivery            = try(each.value.raw_message_delivery, null)
  redrive_policy                  = try(each.value.redrive_policy, null)
  replay_policy                   = try(each.value.replay_policy, null)
  subscription_role_arn           = try(each.value.subscription_role_arn, null)
  topic_arn                       = var.sns_topic_arn
}