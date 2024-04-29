# Creating the log analytics workspace
resource "azurerm_log_analytics_workspace" "example" {
  name                = "mango-workspace-01"
  location            = var.location
  resource_group_name = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
}

resource "azurerm_monitor_diagnostic_setting" "example" {
  name               = "mango-vm-logs01"
  target_resource_id = module.linux.vm_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}