# module "application_gateway" {
#   source                   = "../../../modules/app_gateway"            
#   resource_group_name      = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
#   location                 = var.location
#   virtual_network_name     = module.network.vnet_name
#   subnet_name              = module.network.vnet_subnets_name[3]
#   enable_http2             = var.enable_http2
#   vnet_resource_group_name = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
#   app_gateway_name         = var.app_gateway_name
#   firewall_policy_id       = "${module.waf_policy.waf_policy_id}"
#   sku                      = var.sku
#   backend_address_pools    = var.backend_address_pools
#   backend_http_settings    = var.backend_http_settings
#   http_listeners           = var.http_listeners
#   request_routing_rules    = var.request_routing_rules
#  # ssl_certificates         = var.ssl_certificates
#  depends_on = [ module.network ]
#   tags = {
#     ProjectName = "demo-internal"
#     Env         = "dev"
#   }
# }
