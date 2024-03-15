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