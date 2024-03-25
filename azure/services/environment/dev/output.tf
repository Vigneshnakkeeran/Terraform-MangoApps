#################################### STORAGE ACCOUNT ######################################

output "storage_account_id" {
  description = "The ID of the storage account."
  value       = module.storage.storage_account_id
}

output "storage_account_name" {
  description = "The name of the storage account."
  value       = module.storage.storage_account_name
}

############################################ WAF ###########################################

output "waf_policy_id" {
  description = "Waf Policy ID"
  value       = module.waf_policy.waf_policy_id
}

############################### APPLICATION GATEWAY ##########################################

output "application_gateway_id" {
  description = "The ID of the Application Gateway"
  value       = module.application_gateway.application_gateway_id
}

output "http_listener_id" {
  description = "The ID of the HTTP Listener"
  value       = module.application_gateway.http_listener_id
}

############################### SERVICE BUS ##########################################

output "name" {
  value       = module.service_bus.name
  description = "The namespace name."
}

output "id" {
  value       = module.service_bus.id
  description = "The namespace ID."
}

output "service_bus_topics" {
  description = "Service Bus Topics"
  value = module.service_bus.service_bus_topics
}

output "service_bus_queues" {
  description = "Service Bus Queues"
  value = module.service_bus.service_bus_queues
}