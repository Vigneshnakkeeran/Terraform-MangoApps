resource "azurerm_mysql_flexible_server" "this" {
  count = var.to_provision_mysql == true ? 1 : 0
  name                   = var.mysql_server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  create_mode            = var.create_mode
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password
  zone                   = var.zone
  backup_retention_days  = var.backup_retention_days
  delegated_subnet_id    = var.delegated_subnet_id
  version                = var.mysql_version #"8.0.21"
  sku_name               = var.sku_name #"GP_Standard_D2ds_v4"
  storage {
    auto_grow_enabled = true
    size_gb                = var.size_gb
  }
  high_availability {
    mode = "SameZone"
    standby_availability_zone = var.zone
  }
 identity {
    type         = "UserAssigned"
    identity_ids = var.identity_ids #[azurerm_user_assigned_identity.example.id]
  }

  // Use ignore_changes to prevent Terraform from migrating the MySQL Flexible Server back to its primary Availability Zone after a failover
  lifecycle {
    ignore_changes = [
      high_availability,
      zone,
    ]
  }
}