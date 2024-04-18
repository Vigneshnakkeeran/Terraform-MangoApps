# ## Azure Storage Account
# module "storage" {
#   source  = "../../../../azure/modules/storage_account"
#   resource_group_name      = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
#   location                 = var.location
#   storage_account_name     = "${var.client_name}${var.environment}stacc"
#   account_replication_type = var.storage_account_replication_type
#   account_kind             = var.storage_account_kind
#   account_tier             = var.storage_account_tier

#   # To enable advanced threat protection set argument to `true`
#   enable_advanced_threat_protection = var.enable_storage_account_advanced_threat_protection

#   containers_list = var.enable_storage_account_containers ? var.storage_account_containers : []
 
#    # SMB file share with quota (GB) to create
#   file_shares = var.enable_storage_account_fileshares ? var.storage_account_fileshares : []

#   # Possible types are `SystemAssigned`, `UserAssigned`.
#   managed_identity_type    = "SystemAssigned"
#   tags                     = var.default_tags
# }