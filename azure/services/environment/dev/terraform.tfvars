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
subnet_prefixes    = ["172.16.0.0/24", "172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
subnet_names       = ["private-subnet-01", "private-subnet-02", "public-subnet-01", "public-subnet-02"]

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
    },
    {
      name                   = "app-1"
      priority               = 201
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      source_port_range      = "*"
      destination_port_range = "80"
      source_address_prefix  = "172.16.0.0/16"
      description            = "app-port"
    },
    {
      name                   = "app-2"
      priority               = 201
      direction              = "Inbound"
      access                 = "Allow"
      protocol               = "Tcp"
      source_port_range      = "*"
      destination_port_range = "443"
      source_address_prefix  = "172.16.0.0/16"
      description            = "app-port"
    }
  ]

# ############################# VMSS #############################################

# vmscaleset_name = "ma-dev-vmss-01"
# linux_distribution_name = "ubuntu1804"
# os_flavor = "linux"
# virtual_machine_size = "Standard_D2s_v3"
# instances_count = 2
# enable_autoscale_for_vmss = true
# minimum_instances_count = 2
# maximum_instances_count = 5
# scale_out_cpu_percentage_threshold = 70
# scaling_action_instances_number = 1
# scale_in_cpu_percentage_threshold = 20
# generate_admin_ssh_key =true
# admin_username = "azureadmin"
# admin_password = "Test@123$"
# os_disk_storage_account_type = "Premium_LRS"
# assign_public_ip_to_each_vm_in_vmss = true

##############################   VM      ######################################
size = "Standard_D2s_v3"

############################# STORAGE ACCOUNT #################################

storage_account_replication_type = "LRS"
storage_account_kind = "StorageV2"
storage_account_tier = "Standard"
enable_storage_account_advanced_threat_protection = true
enable_storage_account_containers = true
enable_storage_account_fileshares = true
storage_account_containers = [{ name = "mangoapps-dev-container", access_type = "private" }]
storage_account_fileshares = [{ name = "mangoapps-dev-fileshare", quota = 1000 }]


############################## Application Gateway ###############################
enable_http2         = true
app_gateway_name = "mangoapps-app-gateweay"
sku = {
  name     = "WAF_v2"
  tier     = "WAF_v2"
  capacity = 1
}

backend_address_pools = [
  {
    name         = "backend-pool-target-name"
    ip_addresses = ["172.174.226.251", "172.174.246.106"]
  }
]

backend_http_settings = [
  {
    name                  = "backend-http"
    cookie_based_affinity = "Disabled"
    enable_https          = false
    request_timeout       = 30
    connection_draining = {
      enable_connection_draining = false
      drain_timeout_sec          = 1
    }
  }
  # {
  #   name                  = "backend-https"
  #   cookie_based_affinity = "Disabled"
  #   enable_https          = true
  #   request_timeout       = 30
  #   connection_draining = {
  #     enable_connection_draining = false
  #     drain_timeout_sec          = 1
  #   }
  # }
]

http_listeners = [
  {
    name      = "listener-for-frontend"
    host_name = null
  }
  # {
  #   name                 = "listener-for-frontend-ssl"
  #   ssl_certificate_name = "certification-ssl"
  #   host_name            = null

  # }
]

request_routing_rules = [
  {
    name                       = "routing-rules-list"
    rule_type                  = "Basic"
    priority                   = 1
    http_listener_name         = "listener-for-frontend"
    backend_address_pool_name  = "backend-pool-target-name"
    backend_http_settings_name = "backend-http"
  }
  # {
  #   name                       = "routing-rules-list-ssl"
  #   rule_type                  = "Basic"
  #   priority                   = 2
  #   http_listener_name         = "listener-for-frontend-ssl"
  #   backend_address_pool_name  = "backend-pool-target-name"
  #   backend_http_settings_name = "backend-http"
  # }
]

# ssl_certificates = [
#   {
#     name     = "certification-ssl"
#     data     = "./learningazuretech.pfx"
#     password = "Praveen@1234$"
#   }
# ]

############################# WAF #################################

waf_custom_rules_configuration = [
  {
    name      = "LogAll"
    priority  = 1
    rule_type = "MatchRule"
    action    = "Log"

    match_conditions_configuration = [
      {
        match_variable_configuration = [
          {
            variable_name = "RemoteAddr"
            selector      = null
          }
        ]

        match_values = [
          "192.168.1.0/24"
        ]

        operator           = "IPMatch"
        negation_condition = true
        transforms         = null
      },
      {
        match_variable_configuration = [
          {
            variable_name = "RequestUri"
            selector      = null
          }
        ]

        match_values = [
          "Azure",
          "Cloud"
        ]

        operator           = "Contains"
        negation_condition = true
        transforms         = null
      }
    ]
  }
]

waf_managed_rule_set_configuration = [
  {
    type    = "OWASP"
    version = "3.2"
  },
  {
    type = "Microsoft_BotManagerRuleSet"
    version = "1.0"
  }
]

policy_mode = "Detection"

############################# Service Bus #################################

service_bus_sku = "Standard"

service_bus_namespace_authorization_rules = [
  {
    name = "mangoapps-dev-sb-namespace-authorization-rule"
    rights = ["listen", "send", "manage"]
  }
]

service_bus_topics = [
  {
    name = "mango-apps-sb-topic"
    enable_partioning = true
    subscriptions = [
      {
        name = "mango-apps-sb-topic-queue-subscription"
        forward_to = "mango-apps-sb-queue"
        max_delivery_count = 1
      }
    ]
  }
]

service_bus_queues = [
  {
    name = "mango-apps-sb-queue" 
    authorization_rules = [
      {
        name = "mangoapps-dev-sb-queue-authorization-rule"
        rights = ["listen", "send"]
      }
    ]
  }
]