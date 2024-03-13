# module "vmss" {
#   source                  = "../../../modules/vmss"
#   resource_group_name     = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
#   vmscaleset_name         = var.vmscaleset_name 
#   virtual_network_name    = module.network.vnet_name
#   subnet_name             = module.network.vnet_subnets_name[0]
#   linux_distribution_name = var.linux_distribution_name 
#   os_flavor              = var.os_flavor 
#   linux_distribution_list = {
#     ubuntu1804 = {
#       publisher =  "Canonical"
#       offer     =  "UbuntuServer"
#       sku       =  "18.04-LTS"
#       version   =  "latest"
#     }
#   }
#   virtual_machine_size               = var.virtual_machine_size 
#   instances_count                    = var.instances_count 
#   enable_autoscale_for_vmss          = var.enable_autoscale_for_vmss 
#   minimum_instances_count            = var.minimum_instances_count 
#   maximum_instances_count            = var.maximum_instances_count 
#   scale_out_cpu_percentage_threshold = var.scale_out_cpu_percentage_threshold 
#   scaling_action_instances_number    = var.scaling_action_instances_number 
#   scale_in_cpu_percentage_threshold  = var.scale_in_cpu_percentage_threshold 
#   generate_admin_ssh_key             = var.generate_admin_ssh_key 
#   admin_username                     = var.admin_username 
#   admin_password                     = var.admin_password 
#   os_disk_storage_account_type       = var.os_disk_storage_account_type 
#   assign_public_ip_to_each_vm_in_vmss = var.assign_public_ip_to_each_vm_in_vmss 
#   nsg_inbound_rules = [
#     {
#       name                   = "http"
#       destination_port_range = "80"
#       source_address_prefix  = "*"
#     },
#     {
#       name                   = "https"
#       destination_port_range = "443"
#       source_address_prefix  = "*"
#     },
#   ]
#   tags = {
#     ProjectName  = "demo-internal"
#   }
# }