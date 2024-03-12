# # Azure key-vault for passing the password for VM ##
# data "azurerm_key_vault" "keyvault" {
#    name                = "kv-trfm-intranet-weu-01" 
#    resource_group_name = ""
# }
# data "azurerm_key_vault_secret" "linux" {
#    name = "Standardpassword"
#    key_vault_id = data.azurerm_key_vault.keyvault.id
# }

# ## Module file for creating the linux virtual machine ##
# module "azure_vm" {
# source                       = "../../../../modules/vm_linux"
# network_interface_name       = var.network_interface_name
# location                     = var.location
# azurerm_resource_group_name  = var.azurerm_resource_group_name
# vm_size                      = var.linux_vm_size
# subnet_id                    = var.subnet_id
# virtual_machine_name         = var.virtual_machine_name 
# adminUsername                = var.vm_username
# adminPassword                = data.azurerm_key_vault_secret.linux.value
# shared_image_id              = var.vm_image_id
# #key_data                     = data.azurerm_key_vault_key.example.public_key_openssh
# #datadisk_name                = var.data_disk_name
# #storage_type                 = var.storge_type  // Standard_LRS
# #disk_size                    = var.data_disk_size
# os_profile_name              = var.os_profile_name
# os_disk_name                 = var.os_disk_name
# vm-security-group            = module.vm-security-group.network_security_group_id
# tags                         = var.default_tags
# }
# # ## Security group for linux vm ##
# # module "vm-security-group" {
# #   source                     = "Azure/network-security-group/azurerm"
# #   resource_group_name        = var.azurerm_resource_group_name
# #   location                   = var.location // location for creating the sg
# #   security_group_name        = var.linux_security_group_name
# #   custom_rules = [
# #     {
# #       name                   = "ssh"
# #       priority               = 203
# #       direction              = "Inbound"
# #       access                 = "Allow"
# #       protocol               = "*"
# #       source_port_range      = "*"
# #       destination_port_range = "22"
# #       source_address_prefixes= ["10.131.8.0/21"]
# #       description            = "Allow-the-ssh-connection"
# #     },
# #     {
# #       name                   = "myhttp"
# #       priority               = 201
# #       direction              = "Inbound"
# #       access                 = "Allow"
# #       protocol               = "Tcp"
# #       source_port_range      = "*"
# #       destination_port_range = "80"
# #       source_address_prefixes= ["10.131.8.0/21"]
# #       description            = "Allow-http"
# #     },
# #     {
# #       name                   = "myhttps"
# #       priority               = 202
# #       direction              = "Inbound"
# #       access                 = "Allow"
# #       protocol               = "Tcp"
# #       source_port_range      = "*"
# #       destination_port_range = "443"
# #       source_address_prefixes= ["10.131.8.0/21"]
# #       description            = "Allow-https"
# #     }
# #   ]
# # }