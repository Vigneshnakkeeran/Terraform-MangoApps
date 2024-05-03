# Creating the log analytics workspace
resource "azurerm_log_analytics_workspace" "example" {
  name                = "mango-workspace-01"
  location            = var.location
  resource_group_name = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
}

resource "azurerm_monitor_action_group" "log_analytics" {
  name                = "mango-action-group02"
  resource_group_name = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
  short_name          = "mango01"
  location            = var.location
  webhook_receiver {
    name                    = "log_analytics-webhook"
    service_uri             = "https://${azurerm_log_analytics_workspace.example.workspace_id}.ods.opinsights.azure.com/webhookreceiverid?api-version=2016-04-01"
    use_common_alert_schema = true
  }
}


#===================================================================
# Set Monitoring and Log Analytics Workspace For VM
#===================================================================

resource "azurerm_monitor_activity_log_alert" "vm" {
  name                = "example-activitylogalert"
  resource_group_name = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
  scopes              = [data.terraform_remote_state.dev_resource_group.outputs.dev_rg_id]
  description         = "This alert will monitor a specific rg updates."

  criteria {
    category          = "Recommendation"
    resource_id       = module.linux.vm_id
    operation_name    = "Microsoft.Compute/virtualMachines/write"
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

  enabled = true
  depends_on = [ module.linux ]
}

resource "azurerm_virtual_machine_extension" "vm01" {
  name                       = "test-OMSExtension"
  virtual_machine_id         =  module.linux.vm_id
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "OmsAgentForLinux"
  type_handler_version       = "1.12"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "workspaceId" : "${azurerm_log_analytics_workspace.example.workspace_id}"
    }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
      "workspaceKey" : "${azurerm_log_analytics_workspace.example.primary_shared_key}"
    }
  PROTECTED_SETTINGS
}


#===================================================================
# Set Monitoring and Log Analytics Workspace For AGW
#===================================================================

resource "azurerm_monitor_activity_log_alert" "agw" {
  name                = "agw-activitylogalert"
  resource_group_name = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
  scopes              = [data.terraform_remote_state.dev_resource_group.outputs.dev_rg_id]
  description         = "This alert will monitor a specific rg updates."

  criteria {
    category          = "Recommendation"
    resource_id       = module.application_gateway.application_gateway_id
    operation_name    = "Microsoft.Network/applicationGateways/write"
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

  enabled = true
  depends_on = [ module.application_gateway ]
}
