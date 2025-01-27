module "linux" {
  source = "../../../modules/azure_vm"

  location                   = var.location
  image_os                   = "linux"
  resource_group_name        = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
  allow_extension_operations = true
  custom_data =  base64encode(<<-EOF
    #!/bin/bash
    hostnamectl set-hostname "${var.client_name}01"
    # Add any additional commands here
    EOF
  )
  data_disks = [
    for i in range(1) : {
      name                 = "linuxdisk01"
      storage_account_type = "Standard_LRS"
      create_option        = "Empty"
      disk_size_gb         = 1
      attach_setting = {
        lun     = i
        caching = "ReadWrite"
      }
     # disk_encryption_set_id = azurerm_disk_encryption_set.example.id
    }
  ]
#   new_boot_diagnostics_storage_account = {
#     customer_managed_key = {
#       key_vault_key_id          = azurerm_key_vault_key.storage_account_key.id
#       user_assigned_identity_id = azurerm_user_assigned_identity.storage_account_key_vault.id
#     }
#   }
#   new_network_interface = {
#     ip_forwarding_enabled = false
#     ip_configurations = [
#       {
#         public_ip_address_id = try(azurerm_public_ip.pip.id, null)
#         primary              = true
#       }
#     ]
#   }
  disable_password_authentication = false
  admin_username = "azureuser"
  admin_password =  "Mango@43vm"
#   admin_ssh_keys = [
#     {
#       public_key = tls_private_key.ssh.public_key_openssh
#     }
#   ]
  name = "ubuntu01"
  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  os_simple = "UbuntuServer"
  size      = var.size
  subnet_id = module.network.vnet_subnets[2]

  # depends_on = [azurerm_key_vault_access_policy.des]
}
# resource "azurerm_public_ip" "pip" {
#   name                = "vmPublicIp01"
#   resource_group_name = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
#   location            = var.location
#   allocation_method   = "Static"

#   tags = {
#     environment = "dev"
#   }
# }