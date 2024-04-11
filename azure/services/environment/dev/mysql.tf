resource "azurerm_user_assigned_identity" "mysqldb" {
  count               = var.enable_mysql == true ? 1 : 0
  name                = "${var.mysql_managed_identity_name}-${var.client_name}-${var.environment}"
  resource_group_name = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
  location            = var.location
}
module "mysql_server_primary" {
    source = "../../../modules/mysql_db"
    count = var.enable_mysql == true ? 1 : 0
    mysql_server_name       = "${var.mysql_server_name}-${var.client_name}-${var.environment}"
    resource_group_name     = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
    location                = var.location
    create_mode             = var.create_mode
    mysql_version           = var.mysql_version
    size_gb                 = var.size_gb
    administrator_login     = var.mysql_admin_user
    administrator_password  = data.azurerm_key_vault_secret.mysql_password[0].value
    backup_retention_days   = var.backup_retention_days
    delegated_subnet_id     = module.network.vnet_subnets[0]
    sku_name                = var.mysql_sku_name
    zone                    = var.zone
    identity_ids            = [azurerm_user_assigned_identity.mysqldb[0].id]
}

# whenever we need db creation thorugh terraform uncommnet the below code and publish the module 
# module "mysql_db" {
#     source = "./resource_module/mysql/mysqldb"
#     count = var.enable_mysql == true ? 1 : 0
#     mysql_db_name       = var.mysql_db_name
#     resource_group_name = var.resource_group_name
#     server_name         = module.mysql_server_primary[0].server_name
#     charset             = var.charset  #"utf8"
#     collation           = var.collation #"utf8_unicode_ci"
# }

module "mysql_server_replica01" {
    source = "../../../modules/mysql_db/replica-server"
    count = var.enable_mysql == true ? 1 : 0
    mysql_server_name       = "${var.mysql_replica_01_server_name}-${var.client_name}-${var.environment}"
    resource_group_name     = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
    location                = var.location
    mysql_version           = var.mysql_version
    size_gb                 = var.size_gb
    administrator_login     = var.mysql_admin_user
    administrator_password  = data.azurerm_key_vault_secret.mysql_password[0].value
    backup_retention_days   = var.backup_retention_days
    source_server_id        = module.mysql_server_primary[0].server_id
    delegated_subnet_id     = module.network.vnet_subnets[0]
    sku_name                = var.mysql_sku_name
    zone                    = var.mysql_replica_01_zone
    identity_ids            = [azurerm_user_assigned_identity.mysqldb[0].id]  
}
module "mysql_server_replica02" {
    source = "../../../modules/mysql_db/replica-server"
    count = var.enable_mysql == true ? 1 : 0
    mysql_server_name       = "${var.mysql_replica_02_server_name}-${var.client_name}-${var.environment}"
    resource_group_name     = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
    location                = var.location
    mysql_version           = var.mysql_version
    size_gb                 = var.size_gb
    administrator_login     = var.mysql_admin_user
    administrator_password  = data.azurerm_key_vault_secret.mysql_password[0].value
    backup_retention_days   = var.backup_retention_days
    source_server_id        = module.mysql_server_primary[0].server_id
    delegated_subnet_id     = module.network.vnet_subnets[0]
    sku_name                = var.mysql_sku_name
    zone                    = var.mysql_replica_02_zone
    identity_ids            = [azurerm_user_assigned_identity.mysqldb[0].id]  
}
resource "azurerm_mysql_flexible_server_active_directory_administrator" "primary" {
  count = var.enable_mysql == true ? 1 : 0
  server_id   = module.mysql_server_primary[0].server_id
  identity_id = azurerm_user_assigned_identity.mysqldb[0].id
  login       = data.azuread_group.azuread_group.display_name
  object_id   = data.azurerm_client_config.current.client_id
  tenant_id   = data.azurerm_client_config.current.tenant_id
}
