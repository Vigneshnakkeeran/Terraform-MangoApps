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


####################### Application Load Balancer #######################

alb_certificate_domain_name = "vipinktxing.in"
enable_deletion_protection = false
internal                   = true
ip_address_type            = "ipv4"
load_balancer_type         = "application"

listner_rule_https443_sync  = {
      forward-sync = {
          priority = 1
          actions = [
            {
              type             = "forward"
              target_group_key = "server5223"
            }
          ]
          conditions = [{
            path_pattern = {
              values = ["/mangoappssync*", "/folderSyncList*", "/fpu*", "/fileAccess*"]
            }
          }]
        }
      }


########################## ALB Security Group ####################################

create_alb_sg      = true
alb_sg_description = "Security group for ALB"
alb_ingress_with_cidr_blocks = [
  {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/16"
  },
  {
    from_port   = 5223
    to_port     = 5223
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/16"
  },
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/16"
  }
]

alb_egress_with_cidr_blocks = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "0.0.0.0/0"
  }
]



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

############################# ASG Security Group ##############################

create_asg_sg      = true
asg_sg_description = "Security group for ASG instances"
asg_egress_with_cidr_blocks = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "0.0.0.0/0"
  }
]

##################################### WAF ########################################

# Regional WAF
regional_create_wafv2        = true
regional_waf_visibility_config = {
  cloudwatch_metrics_enabled = true
  metric_name                = "mangoapps-rules-metric"
  sampled_requests_enabled   = true
}

regional_waf_managed_rule_group_statement_rules = [
  {
    name     = "AWS-AWSManagedRulesAmazonIpReputationList"
    priority = 2

    statement = {
      name        = "AWSManagedRulesAmazonIpReputationList"
      vendor_name = "AWS"
    }

    visibility_config = {
      cloudwatch_metrics_enabled = true
      sampled_requests_enabled   = true
      metric_name                = "AWS-AWSManagedRulesAmazonIpReputationList"
    }
  },
  {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 3

    statement = {
      name        = "AWSManagedRulesKnownBadInputsRuleSet"
      vendor_name = "AWS"
    }

    visibility_config = {
      cloudwatch_metrics_enabled = true
      sampled_requests_enabled   = true
      metric_name                = "AWSManagedRulesKnownBadInputsRuleSet-metric"
    }
  },
  {
    name     = "AWSManagedRulesLinuxRuleSet"
    priority = 4
    statement = {
      name        = "AWSManagedRulesLinuxRuleSet"
      vendor_name = "AWS"
    }
    visibility_config = {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesLinuxRuleSet-metric"
      sampled_requests_enabled   = true
    }
  },
  {
    name     = "AWS-AWSManagedRulesAdminProtectionRuleSet"
    priority = 5

    statement = {
      name        = "AWSManagedRulesAdminProtectionRuleSet"
      vendor_name = "AWS"
    }

    visibility_config = {
      cloudwatch_metrics_enabled = true
      sampled_requests_enabled   = true
      metric_name                = "AWSManagedRulesAdminProtectionRuleSet-metric"
    }
  },
  {
    name     = "AWSManagedRulesSQLiRuleSet"
    priority = 6
    statement = {
      name        = "AWSManagedRulesSQLiRuleSet"
      vendor_name = "AWS"
    }
    visibility_config = {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesSQLiRuleSet-metric"
      sampled_requests_enabled   = true
    }
  },
  {
    name            = "AWS-AWSManagedRulesCommonRuleSet"
    priority        = 7
    override_action = "count"
    statement = {
      name        = "AWSManagedRulesCommonRuleSet"
      vendor_name = "AWS"
    }

    visibility_config = {
      cloudwatch_metrics_enabled = true
      sampled_requests_enabled   = true
      metric_name                = "AWSManagedRulesCommonRuleSet-metric"
    }
  }
]

# Cloudfront WAF
cloudfront_create_wafv2        = true
cloudfront_waf_visibility_config = {
  cloudwatch_metrics_enabled = true
  metric_name                = "mangoapps-rules-metric"
  sampled_requests_enabled   = true
}
cloudfront_waf_managed_rule_group_statement_rules = [
  {
    name     = "AWS-AWSManagedRulesAmazonIpReputationList"
    priority = 2

    statement = {
      name        = "AWSManagedRulesAmazonIpReputationList"
      vendor_name = "AWS"
    }

    visibility_config = {
      cloudwatch_metrics_enabled = true
      sampled_requests_enabled   = true
      metric_name                = "AWS-AWSManagedRulesAmazonIpReputationList"
    }
  },
  {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 3

    statement = {
      name        = "AWSManagedRulesKnownBadInputsRuleSet"
      vendor_name = "AWS"
    }

    visibility_config = {
      cloudwatch_metrics_enabled = true
      sampled_requests_enabled   = true
      metric_name                = "AWSManagedRulesKnownBadInputsRuleSet-metric"
    }
  },
  {
    name     = "AWSManagedRulesLinuxRuleSet"
    priority = 4
    statement = {
      name        = "AWSManagedRulesLinuxRuleSet"
      vendor_name = "AWS"
    }
    visibility_config = {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesLinuxRuleSet-metric"
      sampled_requests_enabled   = true
    }
  },
  {
    name     = "AWS-AWSManagedRulesAdminProtectionRuleSet"
    priority = 5

    statement = {
      name        = "AWSManagedRulesAdminProtectionRuleSet"
      vendor_name = "AWS"
    }

    visibility_config = {
      cloudwatch_metrics_enabled = true
      sampled_requests_enabled   = true
      metric_name                = "AWSManagedRulesAdminProtectionRuleSet-metric"
    }
  },
  {
    name     = "AWSManagedRulesSQLiRuleSet"
    priority = 6
    statement = {
      name        = "AWSManagedRulesSQLiRuleSet"
      vendor_name = "AWS"
    }
    visibility_config = {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesSQLiRuleSet-metric"
      sampled_requests_enabled   = true
    }
  },
  {
    name            = "AWS-AWSManagedRulesCommonRuleSet"
    priority        = 7
    override_action = "count"
    statement = {
      name        = "AWSManagedRulesCommonRuleSet"
      vendor_name = "AWS"
    }

    visibility_config = {
      cloudwatch_metrics_enabled = true
      sampled_requests_enabled   = true
      metric_name                = "AWSManagedRulesCommonRuleSet-metric"
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

################################ SNS ####################################

sns_email_subscriptions = {
  email = {
    protocol = "email"
    endpoint = "adarshashok.k@cloudifyops.com"
  }
}

################################ SQS ####################################

create_sqs            = true
sqs_create_fifo_queue = false
sqs_sse_enabled       = true
sqs_create_dlq        = true
max_message_size      = null #262144
message_retention_seconds = null  #provide value in second 345600
enable_content_based_deduplication = true #to enable this fifo queue should also true
