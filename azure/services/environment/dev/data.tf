# For Fetching the Resource Group Data From the Statefile.
data "terraform_remote_state" "dev_resource_group" {
  backend = "azurerm"
  config = {
    resource_group_name  = "ma-tf-backend-rg"
    storage_account_name = "matfbackendst"
    container_name       = "tfstate"
    key                  = "shared/rg/terraform.tfstate"
  } 
}
# # Fetching the MYSQL password
# data "azurerm_key_vault_secret" "mysql_password" {
#    count        = var.enable_mysql ? 1 : 0
#    name         = var.mysql_keyvault_secret_name
#    key_vault_id = data.azurerm_key_vault.keyvault.id
# }