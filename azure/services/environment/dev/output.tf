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