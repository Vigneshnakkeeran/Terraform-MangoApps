############################## Common Variables #################################
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
# securitygroup_name = "vnet-nsg"