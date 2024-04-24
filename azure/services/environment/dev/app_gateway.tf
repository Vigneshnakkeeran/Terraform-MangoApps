module "application_gateway" {
  source                   = "../../../modules/app_gateway"            
  resource_group_name      = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
  location                 = var.location
  virtual_network_name     = module.network.vnet_name
  subnet_name              = module.network.vnet_subnets_name[3]
  enable_http2             = var.enable_http2
  vnet_resource_group_name = data.terraform_remote_state.dev_resource_group.outputs.dev_rg
  app_gateway_name         = var.app_gateway_name
  firewall_policy_id       = "${module.waf_policy.waf_policy_id}"
  sku                      = var.sku
  backend_address_pools = [
  {
    name         = "backend-pool-target-instances"
    ip_addresses = [ local.vm_ip_addresses ] #["172.174.226.251", "172.174.246.106"]
  }
]
frontend_ports = [
  {
   name = "appgw-${var.app_gateway_name}-feport-80"
   port = 80
  },
  {
   name = "appgw-${var.app_gateway_name}-feport-443"
   port = 443
  },
  {
   name = "appgw-${var.app_gateway_name}-feport-5223"
   port = 5223
  }
]
http_listeners = [
  {
    name          = "listener-for-frontend"
    host_name     = null
    protocol      = "Http"
    frontend_port_name   = "appgw-${var.app_gateway_name}-feport-80"
  },
  {
    name                 = "listener-for-frontend-ssl"
    ssl_certificate_name = "certification-ssl"
    host_name            = null
    protocol             = "Https"
    frontend_port_name   = "appgw-${var.app_gateway_name}-feport-443"
  },
  {
    name                 = "listener-new"
    ssl_certificate_name = "certification-ssl"
    host_name              = null
    protocol             = "Https"
    frontend_port_name   = "appgw-${var.app_gateway_name}-feport-5223"
  }
]

backend_http_settings = [
  {
    name                  = "backend-http"
    cookie_based_affinity = "Disabled"
    enable_https          = false
    request_timeout       = 30
    port                  = 80
    connection_draining = {
      enable_connection_draining = false
      drain_timeout_sec          = 1
    }
  },
  {
    name                  = "backend-https"
    cookie_based_affinity = "Disabled"
    enable_https          = true
    port                  = 443
    request_timeout       = 30
    connection_draining = {
      enable_connection_draining = false
      drain_timeout_sec          = 1
    }
  }
  # {
  #   name                  = "backend-https-5223"
  #   cookie_based_affinity = "Disabled"
  #   enable_https          = true
  #   port                  = 5223
  #   request_timeout       = 30
  #   connection_draining = {
  #     enable_connection_draining = false
  #     drain_timeout_sec          = 1
  #   }
  # }
]



request_routing_rules = [
  {
    name                       = "routing-rules-list"
    rule_type                  = "Basic"
    priority                   = 1
    redirect_configuration_name = "rediredt-http-to-https"
    http_listener_name         = "listener-for-frontend"
    backend_address_pool_name  = "backend-pool-target-instances"
    backend_http_settings_name = "backend-http"
   },
  {
    name                       = "routing-rules-list-ssl"
    rule_type                  = "Basic"
    priority                   = 2
    http_listener_name         = "listener-for-frontend-ssl"
    backend_address_pool_name  = "backend-pool-target-instances"
    backend_http_settings_name = "backend-https"
  }
]
redirect_configuration = [
{
      name     = "rediredt-http-to-https"
      rule_type = "Basic"
      target_listener_name = "listener-for-frontend-ssl"
      redirect_type              = "Permanent"
}
]

ssl_certificates = [
  {
    name     = "certification-ssl"
    data     = "./learningazuretech.pfx"
    password = "Praveen@1234$"
  }
]
 depends_on = [ module.network ]
  tags = {
    ProjectName = "demo-internal"
    Env         = "dev"
  }
}

locals {
  vm_ip_addresses = module.linux.network_interface_private_ip
}
