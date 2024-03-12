# data "aws_availability_zones" "available" {}

################################################################################
# EC2 Module
################################################################################

module "ec2_bastion" {
  source = "../../../modules/ec2"

  name =  "${var.client_name}-${var.environment}-bastion-host"
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3a.medium" # used to set core count below
  subnet_id                   = module.vpc.public_subnets
  vpc_security_group_ids      = module.bastion_security_group.security_group_id
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
                                  hostname "${module.ec2_bastion.name}"
                                  echo "${module.ec2_bastion.name}" > /etc/hosts
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

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}
