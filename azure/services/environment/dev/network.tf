## Terraform module for creating the network stack ##
module "network" {
  source              = "../../../modules/network"
  vnet_name           = "${var.client_name}-${var.environment}-${var.vnet_name}"
  resource_group_name = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
  address_spaces      = var.address_spaces 
  subnet_prefixes     = var.subnet_prefixes 
  subnet_names        = var.subnet_names
  use_for_each        = true
  subnet_delegation = {
    "private-subnet-01" = [
      {
        name = "delegation"
        service_delegation = {
           actions = [
                 "Microsoft.Network/virtualNetworks/subnets/join/action",
                ]
          name    = "Microsoft.DBforMySQL/flexibleServers"
        }
      }
    ]
   }
  tags                = var.default_tags
}

## Resource block for attaching the subnet with security group ##
resource "azurerm_subnet_network_security_group_association" "nsg-assoc" {
  count                      = length(module.network.vnet_subnets) > 2 ? 2 : 0
  subnet_id                  = module.network.vnet_subnets[count.index]
  network_security_group_id  = module.network-security-group.network_security_group_id
  depends_on = [ module.network ]
}
