################################ Common ####################################

client_name = "mango-apps"
environment = "dev"

################################ Network ####################################

vpc_cidr                           = "172.16.0.0/16"
public_subnets                     = ["172.16.0.0/24", "172.16.1.0/24"]
private_subnets                    = ["172.16.6.0/24", "172.16.7.0/24"]
enable_nat_gateway                 = true
single_nat_gateway                 = true
one_nat_gateway_per_az             = false
create_igw                         = true

############################ Bastion Host ##################################

bastion_instance_type = "t2.micro"

################################ ASG ####################################

asg_min_size                    = 1
asg_max_size                    = 5
asg_desired_size                = 2
asg_ami_id                      = "ami-0f403e3180720dd7e"
asg_instance_type               = "t3.medium"
asg_key_name                    = "mango-apps-dev-asg-key"
create_asg_iam_instance_profile = true
asg_instance_ebs_optimized      = false
enable_asg_monitoring           = true
asg_volume_mapping = [
  {
    # Root volume
    device_name = "/dev/xvda"
    no_device   = 0
    ebs = {
      delete_on_termination = true
      encrypted             = true
      volume_size           = 20
      volume_type           = "gp3"
    }
  },

  # Additional volume
  {
    device_name = "/dev/sdf"
    no_device   = 1
    ebs = {
      delete_on_termination = true
      encrypted             = true
      volume_size           = 10
      volume_type           = "gp3"
    }
  }
]

################################ S3 ####################################

create_s3_bucket = true
acl              = "private"
versioning = {
  "status" = "enabled"
}
block_public_acls        = true
block_public_policy      = true
ignore_public_acls       = true
restrict_public_buckets  = true
control_object_ownership = true
object_ownership         = "ObjectWriter"
server_side_encryption_configuration = {
  rule = {
    apply_server_side_encryption_by_default = {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

############################# ASG Security Group ##############################

create_asg_sg      = true
asg_sg_description = "Security group for ASG instances"
asg_ingress_with_cidr_blocks = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "SSH Access to instances"
    cidr_blocks = "0.0.0.0/0"
  }
]

asg_egress_with_cidr_blocks = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "0.0.0.0/0"
  }
]

############################# Bastion Host Security Group ##############################

create_bastion_sg      = true
bastion_sg_description = "Security group for Bastion Host"
bastion_ingress_with_cidr_blocks = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "SSH Access from anywhere"
    cidr_blocks = "0.0.0.0/0"
  }
]
bastion_egress_with_cidr_blocks = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "0.0.0.0/0"
  }
]


############################################################################
