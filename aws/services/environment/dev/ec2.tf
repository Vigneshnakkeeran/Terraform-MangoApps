# data "aws_availability_zones" "available" {}
locals {
 instance_name = "${var.client_name}-${var.environment}-private-host"
}
################################################################################
# EC2 Module
################################################################################

module "ec2_bastion" {
  source = "../../../modules/ec2"

  name =  local.instance_name
  ami                         = "ami-07d9b9ddc6cd8dd30"
  instance_type               = "t3a.medium" # used to set core count below
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [module.bastion_security_group.security_group_id]
  associate_public_ip_address = true
  key_name        = var.asg_key_name
  create_iam_instance_profile = false
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }

  # only one of these can be enabled at a time
  hibernation = false
  # enclave_options_enabled = true

  user_data            = <<-EOF
                                  #!/bin/bash
                                  echo "${local.instance_name}" > /etc/hostname
                                  # Add any additional commands here
                                  EOF
  user_data_replace_on_change = true
  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 50
      tags = {
        Name = "my-root-block"
      }
    },
  ]

  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp3"
      volume_size = 5
      throughput  = 200
      encrypted   = false
    }
  ]

  tags = {
    Created_by = "Terraform"
  }
}

################ EC2 In Private Subnet ###################

module "ec2_bastion" {
  source = "../../../modules/ec2"

  name =  local.instance_name
  ami                         = "ami-07d9b9ddc6cd8dd30"
  instance_type               = "t3a.medium" # used to set core count below
  subnet_id                   = module.vpc.rpivate_subnets[0]
  vpc_security_group_ids      = [module.private_security_group.security_group_id]
  associate_public_ip_address = false
  key_name        = var.asg_key_name
  create_iam_instance_profile = false
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }

  # only one of these can be enabled at a time
  hibernation = false
  # enclave_options_enabled = true

  user_data            = <<-EOF
                                  #!/bin/bash
                                  echo "${local.instance_name}" > /etc/hostname
                                  # Add any additional commands here
                                  EOF
  user_data_replace_on_change = true
  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 50
      tags = {
        Name = "my-root-block"
      }
    },
  ]

  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp3"
      volume_size = 5
      throughput  = 200
      encrypted   = false
    }
  ]

  tags = {
    Created_by = "Terraform"
  }
}

