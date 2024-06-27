# # data "aws_availability_zones" "available" {}
# locals {
#  instance_name = "${var.client_name}-${var.environment}-private-host"
# }
################################################################################
# EC2 Module
################################################################################

module "ec2_bastion" {
  source = "../../../../modules/ec2"

  name =  "${var.client_name}bastion-host"
  ami                         = "ami-08116b9957a259459"
  instance_type               = "t3a.medium"
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [module.bastion_security_group.security_group_id]
  associate_public_ip_address = true
  key_name        = var.bastion_key_name
  create_iam_instance_profile = false

  # only one of these can be enabled at a time
  hibernation = false
  # enclave_options_enabled = true

  user_data            = <<-EOF
                                  #!/bin/bash
                                  hostnamectl set-hostname "${var.client_name}bastion-host"
                                  # Add any additional commands here
                                  EOF
  # user_data_replace_on_change = true
  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 50
      tags = {
        Name = "bastion-root-block"
      }
    }
  ]

  tags = {
    Created_by = "Terraform"
  }
}

################ Frontend ###################

module "ec2_frontendserver" {
  source = "../../../../modules/ec2"

  name =   "${var.client_name}01"
  ami                         = "ami-04377a4b42b31e8e5"
  instance_type               = "r6a.2xlarge"
  subnet_id                   = module.vpc.private_subnets[0]
  vpc_security_group_ids      = [module.backend_security_group.security_group_id]
  associate_public_ip_address = false
  key_name        = var.frontend_key_name
  create_iam_instance_profile = true
  iam_role_use_name_prefix = false
  iam_role_name = "ma-ec2-instace-role"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 8
    instance_metadata_tags      = "enabled"
  }

  disable_api_termination = true

  # only one of these can be enabled at a time
  hibernation = false
  # enclave_options_enabled = true

  user_data            = <<-EOF
                                  #!/bin/bash
                                  hostnamectl set-hostname "${var.client_name}01"
                                  # Add any additional commands here
                                  EOF
  # user_data_replace_on_change = true
  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp2"
      throughput  = 0
      volume_size = 200
      tags = {
        Name = "frontend-root-block"
      }
    }
  ]

  tags = {
    Created_by = "Terraform"
  }
}

################ Backend ###################

module "ec2_backendserver" {
  source = "../../../../modules/ec2"

  name = "${var.client_name}11"
  ami                         = "ami-04377a4b42b31e8e5"
  instance_type               = "r6a.2xlarge"
  subnet_id                   = module.vpc.private_subnets[0]
  vpc_security_group_ids      = [module.backend_security_group.security_group_id]
  associate_public_ip_address = false
  key_name        = var.backend_key_name
  create_iam_instance_profile = false
  iam_instance_profile = "ma-ec2-instace-role"

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 8
    instance_metadata_tags      = "enabled"
  }  

  disable_api_termination = true  

  # only one of these can be enabled at a time
  hibernation = false
  # enclave_options_enabled = true

  user_data            = <<-EOF
                                  #!/bin/bash
                                  hostnamectl set-hostname "${var.client_name}11"
                                  # Add any additional commands here
                                  EOF
  # user_data_replace_on_change = true
  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 100
      tags = {
        Name = "backend-root-block"
      }
    }
  ]

  tags = {
    Created_by = "Terraform"
  }
}

###########################################
##########Backend server02################

module "ec2_frontendserver_02" {
  source = "../../../../modules/ec2"

  name =   "${var.client_name}21"
  ami                         = "ami-04377a4b42b31e8e5"
  instance_type               = "r6a.2xlarge"
  subnet_id                   = module.vpc.private_subnets[0]
  vpc_security_group_ids      = [module.backend_security_group.security_group_id]
  associate_public_ip_address = false
  key_name        = var.frontend_key_name
  create_iam_instance_profile = false
  iam_instance_profile = "ma-ec2-instace-role"

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 8
    instance_metadata_tags      = "enabled"
  }  

  disable_api_termination = true

  # only one of these can be enabled at a time
  hibernation = false
  # enclave_options_enabled = true

  user_data            = <<-EOF
                                  #!/bin/bash
                                  hostnamectl set-hostname "${var.client_name}21"
                                  # Add any additional commands here
                                  EOF
  # user_data_replace_on_change = true
  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 100
      tags = {
        Name = "frontend-root-block"
      }
    },
  ]

  tags = {
    Created_by = "Terraform"
  }
}
