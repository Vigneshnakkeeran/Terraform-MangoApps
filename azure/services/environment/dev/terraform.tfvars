############################## Common Variables ################################

location        = "eastus"
default_tags    = {
  Created_by    = "Terraform"
    }
environment     = "dev"
client_name     = "ma"

############################## NETWORK ##########################################

use_for_each       = false
vnet_name          = "vnet"
address_spaces     = ["172.16.0.0/16"]
subnet_prefixes    = ["172.16.0.0/24", "172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24", "172.16.4.0/24" ]
subnet_names       = ["private-subnet-01", "private-subnet-02", "private-subnet-03", "public-subnet-01", "public-subnet-02"]

############################## SECURITY GROUP ####################################

securitygroup_name = "vnet-nsg"
custom_rules = [
    {
      name                   = "ssh"
      priority               = 200
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      source_port_range      = "*"
      destination_port_range = "22"
      source_address_prefix  = "172.16.0.0/16"
      description            = "description-myssh"
    }
  ]

############################# VMSS #############################################

vmscaleset_name = "ma-dev-vmss-01"
linux_distribution_name = "ubuntu1804"
os_flavor = "linux"
virtual_machine_size = "Standard_D2s_v3"
instances_count = 2
enable_autoscale_for_vmss = true
minimum_instances_count = 2
maximum_instances_count = 5
scale_out_cpu_percentage_threshold = 70
scaling_action_instances_number = 1
scale_in_cpu_percentage_threshold = 20
generate_admin_ssh_key =true
admin_username = "azureadmin"
admin_password = "Test@123$"
os_disk_storage_account_type = "Premium_LRS"
assign_public_ip_to_each_vm_in_vmss = true

############################# STORAGE ACCOUNT #################################

storage_account_replication_type = "LRS"
storage_account_kind = "StorageV2"
storage_account_tier = "Standard"
enable_storage_account_advanced_threat_protection = true
enable_storage_account_containers = true
enable_storage_account_fileshares = true
storage_account_containers = [{ name = "mangoapps-dev-container", access_type = "private" }]
storage_account_fileshares = [{ name = "mangoapps-dev-fileshare", quota = 1000 }]