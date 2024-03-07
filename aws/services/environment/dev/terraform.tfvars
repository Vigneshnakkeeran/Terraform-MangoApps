################################ Common ####################################

client_name = "mango-apps"
environment = "dev"

################################ Network ####################################

vpc_cidr                           = "172.16.0.0/16"
public_subnets                     = ["172.16.0.0/24", "172.16.1.0/24"]
private_subnets                    = ["172.16.6.0/24", "172.16.7.0/24"]
database_subnets                   = ["172.16.12.0/24", "172.16.13.0/24", "172.16.14.0/24"]
create_database_subnet_group       = true
create_database_subnet_route_table = true
enable_nat_gateway                 = true
create_database_nat_gateway_route  = false
single_nat_gateway                 = true
one_nat_gateway_per_az             = false
create_igw                         = true

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

################################ RDS ####################################

rds_aurora_allow_major_version_upgrade = false
rds_aurora_apply_immediately           = false
rds_aurora_instance_class              = "db.r6g.large"
rds_aurora_engine                      = "aurora-mysql"
rds_aurora_engine_mode                 = "provisioned"
rds_aurora_engine_version              = "8.0"
rds_aurora_manage_master_user_password = true
# rds_aurora_master_password                 = "testing@123"
rds_aurora_master_username                 = "testing"
rds_aurora_storage_encrypted               = true
rds_aurora_enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
rds_aurora_publicly_accessible             = false

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

################################ SQS ####################################

sqs_create_fifo_queue = false
sqs_sse_enabled       = true
sqs_create_dlq        = true


############################# ASG Security Group ##############################

create_asg_sg      = true
asg_sg_description = "Security group for ASG instances"
asg_ingress_with_cidr_blocks = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "SSH Access to instances"
    cidr_blocks = "172.16.0.0/16"
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

############################# RDS Security Group ##############################

create_rds_sg      = true
rds_sg_description = "Security group for ASG instances"
rds_ingress_with_cidr_blocks = [
  {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    description = "MySQL Access within VPC"
    cidr_blocks = "172.16.0.0/16"
  }
]

rds_egress_with_cidr_blocks = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "0.0.0.0/0"
  }
]

############################################################################