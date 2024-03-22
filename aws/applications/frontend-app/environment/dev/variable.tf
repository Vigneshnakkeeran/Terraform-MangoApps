################### Common Variables ##########################

variable "client_name" {
  description = "Client Name"
  type        = string
}

variable "environment" {
  description = "Environment Name"
  type        = string
}



################## ASG variables ##########################

variable "asg_min_size" {
  description = "Minimum Size for the ASG"
  type        = number
}

variable "asg_max_size" {
  description = "Maximum Size for the ASG"
  type        = number
}

variable "asg_desired_size" {
  description = "Desired Size for the ASG"
  type        = number
}

variable "asg_ami_id" {
  description = "AMI ID for the ASG Launch Template"
  type        = string
}

variable "asg_instance_type" {
  description = "Instance type for the ASG Launch Template"
  type        = string
}

variable "create_asg_iam_instance_profile" {
  description = "If enabled, creates instance profiles for the instances launched by the ASG"
  type        = bool
}

variable "asg_instance_ebs_optimized" {
  description = "If enabled, the instances launched by the ASG will be EBS optimized"
  type        = bool
}

variable "enable_asg_monitoring" {
  description = "Enables monitoring for the ASG"
  type        = bool
}

variable "asg_volume_mapping" {
  description = "EBS Volume mappings for ASG"
  type        = list(any)
}

variable "asg_key_name" {
  description = "Key Pair used for SSH to ASG instances"
  type        = string
}


################## ASG Security Group variables ##########################

variable "create_asg_sg" {
  description = "Whether to create security group for ASG"
  type        = bool
}

variable "asg_sg_description" {
  description = "Security Group for instances created by the ASG"
  type        = string
}

# variable "asg_ingress_with_cidr_blocks" {
#   description = "List of ingress rules to create where 'cidr_blocks' is used"
#   type        = list(map(string))
# }

# variable "asg_ingress_with_source_security_group_id" {
#   description = "List of ingress rules to create where 'security group' is used"
#   type        = list(map(string))
# }

variable "asg_egress_with_cidr_blocks" {
  description = "List of egress rules to create by name"
  type        = list(map(string))
}


