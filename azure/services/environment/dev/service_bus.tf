# module "service_bus" {
#   source = "../../../modules/service_bus"

#   name        = "${var.client_name}-${var.environment}-service-bus"
#   resource_group_name =  data.terraform_remote_state.dev_resource_group.outputs.dev_rg
#   location            = var.location

#   sku = var.service_bus_sku

#   # Only applicable when sku = "Premium". For sku = "Basic/Standard", capacity can only be 0.
#   capacity = var.service_bus_capacity
#   authorization_rules = var.service_bus_namespace_authorization_rules  

#   topics = var.service_bus_topics
#   queues = var.service_bus_queues

#   tags = var.default_tags
# }