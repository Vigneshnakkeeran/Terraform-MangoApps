################### Common Variables ##########################

variable "client_name" {
  description = "Client Name"
  type        = string
}

variable "environment" {
  description = "Environment Name"
  type        = string
}

################## Network variables ##########################

variable "vpc_cidr" {
  description = "mention the cidr_block range for the vpc"
  type        = string
  default     = ""
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
}

variable "one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `azs`"
  type        = bool
}

variable "create_igw" {
  description = "Should be true if you want to create IGW"
  type        = bool
}

################## Bastion Host variables ##########################

variable "bastion_instance_type" {
  description = "Instance Type used by the Bastion Host"
  type = string
}



################################# ALB Variables #######################################

variable "alb_certificate_domain_name" {
  description = "Provide The alb Certificate Domain name present in ACM with Issued status."
  type = string
}

variable "enable_deletion_protection" {
  description = "If `true`, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer."
  type        = bool
}

variable "internal" {
  description = "If true, the LB will be internal."
  type        = bool
}

variable "ip_address_type" {
  description = "The type of IP addresses used by the subnets for your load balancer. The possible values are `ipv4` and `dualstack`"
  type        = string
}

variable "load_balancer_type" {
  description = "The type of load balancer to create. Possible values are `application`, `gateway`, or `network`. The default value is `application`"
  type        = string
}

variable "listner_rule_https443_sync" {
  description = "value"
  type = any
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

################## S3 variables ##########################

variable "create_s3_bucket" {
  description = "Controls if S3 bucket should be created"
  type        = bool
}

variable "acl" {
  description = "(Optional) The canned ACL to apply. Conflicts with `grant`"
  type        = string
}

variable "versioning" {
  description = "Map containing versioning configuration."
  type        = map(string)
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  type        = bool
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  type        = bool
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  type        = bool
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
}

variable "control_object_ownership" {
  description = "Whether to manage S3 Bucket Ownership Controls on this bucket."
  type        = bool
}

variable "object_ownership" {
  description = "Object ownership. Valid values: BucketOwnerEnforced, BucketOwnerPreferred or ObjectWriter. 'BucketOwnerEnforced': ACLs are disabled, and the bucket owner automatically owns and has full control over every object in the bucket. 'BucketOwnerPreferred': Objects uploaded to the bucket change ownership to the bucket owner if the objects are uploaded with the bucket-owner-full-control canned ACL. 'ObjectWriter': The uploading account will own the object if the object is uploaded with the bucket-owner-full-control canned ACL."
  type        = string
}

variable "server_side_encryption_configuration" {
  description = "server side encryption configuration"
  type        = map(any)
}

# ####################### RDS Aurora variables #############################

# variable "rds_aurora_allow_major_version_upgrade" {
#   description = "Enable to allow major engine version upgrades when changing engine versions. Defaults to `false`"
#   type        = bool
# }

# variable "rds_aurora_apply_immediately" {
#   description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. Default is `false`"
#   type        = bool
# }

# variable "rds_aurora_instance_class" {
#   description = "Instance type to use at master instance. Note: if `autoscaling_enabled` is `true`, this will be the same instance class used on instances created by autoscaling"
#   type        = string
#   default     = ""
# }

# variable "rds_aurora_engine" {
#   description = "The name of the database engine to be used for this DB cluster. Defaults to `aurora`. Valid Values: `aurora`, `aurora-mysql`, `aurora-postgresql`"
#   type        = string
#   default     = null
# }

# variable "rds_aurora_engine_mode" {
#   description = "The database engine mode. Valid values: `global`, `multimaster`, `parallelquery`, `provisioned`, `serverless`. Defaults to: `provisioned`"
#   type        = string
#   default     = "provisioned"
# }

# variable "rds_aurora_engine_version" {
#   description = "The database engine version. Updating this argument results in an outage"
#   type        = string
#   default     = null
# }

# variable "rds_aurora_manage_master_user_password" {
#   description = "Set to true to allow RDS to manage the master user password in Secrets Manager. Cannot be set if `master_password` is provided"
#   type        = bool
#   default     = true
# }

# # variable "master_password" {
# #   description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file. Required unless `manage_master_user_password` is set to `true` or unless `snapshot_identifier` or `replication_source_identifier` is provided or unless a `global_cluster_identifier` is provided when the cluster is the secondary cluster of a global database"
# #   type        = string
# #   default     = null
# # }

# variable "rds_aurora_master_username" {
#   description = "Username for the master DB user. Required unless `snapshot_identifier` or `replication_source_identifier` is provided or unless a `global_cluster_identifier` is provided when the cluster is the secondary cluster of a global database"
#   type        = string
#   default     = null
# }

# variable "rds_aurora_storage_encrypted" {
#   description = "Specifies whether the DB cluster is encrypted. The default is `true`"
#   type        = bool
# }

# variable "rds_aurora_enabled_cloudwatch_logs_exports" {
#   description = "Set of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: `audit`, `error`, `general`, `slowquery`, `postgresql`"
#   type        = list(string)
# }

# variable "rds_aurora_publicly_accessible" {
#   description = "Determines whether instances are publicly accessible. Default `false`"
#   type        = bool
# }

# ################## SNS Variables ##########################

# variable "sns_email_subscriptions" {
#   description = "A map of subscription definitions to create"
#   type        = any
#   default     = null
# }

# ################## SQS Variables ##########################

# variable "create_sqs" {
#   description = "Whether to create SQS or not."
#   type = bool
# }

# variable "sqs_create_fifo_queue" {
#   description = "Should be true if you want to create fifo queue"
#   type        = bool
# }

# variable "sqs_sse_enabled" {
#   description = "Should  be true if you want to enable server side encription"
#   type        = bool
# }

# variable "sqs_create_dlq" {
#   description = "Should be true if you want to create SQS dead letter queue"
#   type        = bool
# }

# variable "max_message_size" {
#   description =  "The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB)"
#   type        = number
# }

# variable "message_retention_seconds" {
#   description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days) default valu is 4days"
#   type        = number
# }  

# variable "enable_content_based_deduplication" {
#   description = "Should be true to enables content-based deduplication for FIFO queues."
#   type = bool
# }


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



########################### ALB Security Group #############################################

variable "create_alb_sg" {
  description = "Whether to create security group for Application Load Balancer"
  type        = bool
}

variable "alb_sg_description" {
  description = "Security Group for ALB"
  type        = string
}

variable "alb_ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where 'cidr_blocks' is used"
  type        = list(map(string))
}

# variable "alb_ingress_with_source_security_group_id" {
#   description = "List of ingress rules to create where 'security group' is used"
#   type        = list(map(string))
# }

variable "alb_egress_with_cidr_blocks" {
  description = "List of egress rules to create by name"
  type        = list(map(string))
}

# ################## RDS Security Group variables ##########################

# variable "create_rds_sg" {
#   description = "Whether to create security group for ASG"
#   type        = bool
# }

# variable "rds_sg_description" {
#   description = "Security Group for instances created by the ASG"
#   type        = string
# }

# variable "rds_ingress_with_cidr_blocks" {
#   description = "List of ingress rules to create where 'cidr_blocks' is used"
#   type        = list(map(string))
# }

# # variable "rds_ingress_with_source_security_group_id" {
# #   description = "List of ingress rules to create where 'security group' is used"
# #   type        = list(map(string))
# # }

# variable "rds_egress_with_cidr_blocks" {
#   description = "List of egress rules to create by name"
#   type        = list(map(string))
# }

################## Bastion Host Security Group variables ##########################

variable "create_bastion_sg" {
  description = "Whether to create security group for Bastion Host"
  type        = bool
}

variable "bastion_sg_description" {
  description = "Security Group for instances created by the Bastion Host"
  type        = string
}

variable "bastion_ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where 'cidr_blocks' is used"
  type        = list(map(string))
}

# variable "bastion_ingress_with_source_security_group_id" {
#   description = "List of ingress rules to create where 'security group' is used"
#   type        = list(map(string))
# }

variable "bastion_egress_with_cidr_blocks" {
  description = "List of egress rules to create by name"
  type        = list(map(string))
}

################################ WAF ####################################

# Regional
variable "regional_create_wafv2" {
  description = "Choose whether the waf should be created or not"
  type = bool
}

variable "regional_waf_visibility_config" {
  description = "Defines and enables Amazon CloudWatch metrics and web request sample collection."
  type = object({
    cloudwatch_metrics_enabled = bool
    metric_name                = string
    sampled_requests_enabled   = bool
  })
}

variable "regional_waf_whitelist_ipset_name" {
  description = "Name for the IPSet to be whitelisted in WAF"
  type = string
  default = ""
}

# Regional WAF Rules
variable "regional_waf_byte_match_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement that defines a string match search for AWS WAF to apply to web requests."
}

variable "regional_waf_geo_allowlist_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to identify a list of allowed countries which should not be blocked by the WAF."
}

variable "regional_waf_geo_match_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to identify web requests based on country of origin."
}

variable "regional_waf_ip_set_reference_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to detect web requests coming from particular IP addresses or address ranges."
}

variable "regional_waf_managed_rule_group_statement_rules" {
  type = list(object({
    name            = string
    priority        = number
    override_action = optional(string)
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement = object({
      name        = string
      vendor_name = string
      version     = optional(string)
      rule_action_override = optional(map(object({
        action = string
        custom_request_handling = optional(object({
          insert_header = object({
            name  = string
            value = string
          })
        }), null)
        custom_response = optional(object({
          response_code = string
          response_header = optional(object({
            name  = string
            value = string
          }), null)
        }), null)
      })), null)
      managed_rule_group_configs = optional(list(object({
        aws_managed_rules_bot_control_rule_set = optional(object({
          inspection_level = string
        }), null)
        aws_managed_rules_atp_rule_set = optional(object({
          enable_regex_in_path = optional(bool)
          login_path           = string
          request_inspection = optional(object({
            payload_type = string
            password_field = object({
              identifier = string
            })
            username_field = object({
              identifier = string
            })
          }), null)
          response_inspection = optional(object({
            body_contains = optional(object({
              success_strings = list(string)
              failure_strings = list(string)
            }), null)
            header = optional(object({
              name           = string
              success_values = list(string)
              failure_values = list(string)
            }), null)
            json = optional(object({

              identifier      = string
              success_strings = list(string)
              failure_strings = list(string)
            }), null)
            status_code = optional(object({
              success_codes = list(string)
              failure_codes = list(string)
            }), null)
          }), null)
        }), null)
      })), null)
    })
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to run the rules that are defined in a managed rule group."
}

variable "regional_waf_rate_based_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rate-based rule tracks the rate of requests for each originating IP address,and triggers the rule action when the rate exceeds a limit that you specify on the number of requests in any 5-minute time span."
}

variable "regional_waf_regex_pattern_set_reference_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to search web request components for matches with regular expressions."
}

variable "regional_waf_regex_match_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to search web request components for a match against a single regular expression."
}

variable "regional_waf_rule_group_reference_statement_rules" {
  type = list(object({
    name            = string
    priority        = number
    override_action = optional(string)
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement = object({
      arn = string
      rule_action_override = optional(map(object({
        action = string
        custom_request_handling = optional(object({
          insert_header = object({
            name  = string
            value = string
          })
        }), null)
        custom_response = optional(object({
          response_code = string
          response_header = optional(object({
            name  = string
            value = string
          }), null)
        }), null)
      })), null)
    })
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to run the rules that are defined in an WAFv2 Rule Group."
}

variable "regional_waf_size_constraint_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement that uses a comparison operator to compare a number of bytes against the size of a request component."
}

variable "regional_waf_sqli_match_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "An SQL injection match condition identifies the part of web requests, such as the URI or the query string, that you want AWS WAF to inspect."
}

variable "regional_waf_xss_match_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement that defines a cross-site scripting (XSS) match search for AWS WAF to apply to web requests."
}

# Cloudfront
variable "cloudfront_create_wafv2" {
  description = "Choose whether the waf should be created or not"
  type = bool
}

variable "cloudfront_waf_visibility_config" {
  description = "Defines and enables Amazon CloudWatch metrics and web request sample collection."
  type = object({
    cloudwatch_metrics_enabled = bool
    metric_name                = string
    sampled_requests_enabled   = bool
  })
}

variable "cloudfront_waf_whitelist_ipset_name" {
  description = "Name for the IPSet to be whitelisted in WAF"
  type = string
  default = ""
}

# Cloudfront WAF Rules
variable "cloudfront_waf_byte_match_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement that defines a string match search for AWS WAF to apply to web requests."
}

variable "cloudfront_waf_geo_allowlist_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to identify a list of allowed countries which should not be blocked by the WAF."
}

variable "cloudfront_waf_geo_match_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to identify web requests based on country of origin."
}

variable "cloudfront_waf_ip_set_reference_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to detect web requests coming from particular IP addresses or address ranges."
}

variable "cloudfront_waf_managed_rule_group_statement_rules" {
  type = list(object({
    name            = string
    priority        = number
    override_action = optional(string)
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement = object({
      name        = string
      vendor_name = string
      version     = optional(string)
      rule_action_override = optional(map(object({
        action = string
        custom_request_handling = optional(object({
          insert_header = object({
            name  = string
            value = string
          })
        }), null)
        custom_response = optional(object({
          response_code = string
          response_header = optional(object({
            name  = string
            value = string
          }), null)
        }), null)
      })), null)
      managed_rule_group_configs = optional(list(object({
        aws_managed_rules_bot_control_rule_set = optional(object({
          inspection_level = string
        }), null)
        aws_managed_rules_atp_rule_set = optional(object({
          enable_regex_in_path = optional(bool)
          login_path           = string
          request_inspection = optional(object({
            payload_type = string
            password_field = object({
              identifier = string
            })
            username_field = object({
              identifier = string
            })
          }), null)
          response_inspection = optional(object({
            body_contains = optional(object({
              success_strings = list(string)
              failure_strings = list(string)
            }), null)
            header = optional(object({
              name           = string
              success_values = list(string)
              failure_values = list(string)
            }), null)
            json = optional(object({

              identifier      = string
              success_strings = list(string)
              failure_strings = list(string)
            }), null)
            status_code = optional(object({
              success_codes = list(string)
              failure_codes = list(string)
            }), null)
          }), null)
        }), null)
      })), null)
    })
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to run the rules that are defined in a managed rule group."
}

variable "cloudfront_waf_rate_based_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rate-based rule tracks the rate of requests for each originating IP address,and triggers the rule action when the rate exceeds a limit that you specify on the number of requests in any 5-minute time span."
}

variable "cloudfront_waf_regex_pattern_set_reference_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to search web request components for matches with regular expressions."
}

variable "cloudfront_waf_regex_match_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to search web request components for a match against a single regular expression."
}

variable "cloudfront_waf_rule_group_reference_statement_rules" {
  type = list(object({
    name            = string
    priority        = number
    override_action = optional(string)
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement = object({
      arn = string
      rule_action_override = optional(map(object({
        action = string
        custom_request_handling = optional(object({
          insert_header = object({
            name  = string
            value = string
          })
        }), null)
        custom_response = optional(object({
          response_code = string
          response_header = optional(object({
            name  = string
            value = string
          }), null)
        }), null)
      })), null)
    })
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement used to run the rules that are defined in an WAFv2 Rule Group."
}

variable "cloudfront_waf_size_constraint_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement that uses a comparison operator to compare a number of bytes against the size of a request component."
}

variable "cloudfront_waf_sqli_match_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "An SQL injection match condition identifies the part of web requests, such as the URI or the query string, that you want AWS WAF to inspect."
}

variable "cloudfront_waf_xss_match_statement_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    captcha_config = optional(object({
      immunity_time_property = object({
        immunity_time = number
      })
    }), null)
    rule_label = optional(list(string), null)
    statement  = any
    visibility_config = optional(object({
      cloudwatch_metrics_enabled = optional(bool)
      metric_name                = string
      sampled_requests_enabled   = optional(bool)
    }), null)
  }))
  default     = null
  description = "A rule statement that defines a cross-site scripting (XSS) match search for AWS WAF to apply to web requests."
}

#######################################################################
