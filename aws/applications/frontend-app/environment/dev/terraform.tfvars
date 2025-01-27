################################ Common ####################################

client_name = "mango-apps"
environment = "dev"

################################ ASG ####################################

asg_min_size                    = 1
asg_max_size                    = 5
asg_desired_size                = 1
asg_ami_id                      = "ami-02f0f3474e47134b3"
asg_instance_type               = "r6a.2xlarge"
asg_key_name                    = "mango-apps-dev-frontend-key"
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
      volume_size           = 50
      volume_type           = "gp3"
    }
  },

  # # Additional volume
  # {
  #   device_name = "/dev/sdf"
  #   no_device   = 1
  #   ebs = {
  #     delete_on_termination = true
  #     encrypted             = true
  #     volume_size           = 10
  #     volume_type           = "gp3"
  #   }
  # }
]

# ############################# ASG Security Group ##############################

# create_asg_sg      = true
# asg_sg_description = "Security group for ASG instances"
# asg_egress_with_cidr_blocks = [
#   {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = "0.0.0.0/0"
#   }
# ]
