<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.20 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.40.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb_security_group"></a> [alb\_security\_group](#module\_alb\_security\_group) | ../../../modules/security-group | n/a |
| <a name="module_bastion_security_group"></a> [bastion\_security\_group](#module\_bastion\_security\_group) | ../../../modules/security-group | n/a |
| <a name="module_lb"></a> [lb](#module\_lb) | ../../../modules/alb | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.mangoapp_cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl"></a> [acl](#input\_acl) | (Optional) The canned ACL to apply. Conflicts with `grant` | `string` | n/a | yes |
| <a name="input_alb_certificate_domain_name"></a> [alb\_certificate\_domain\_name](#input\_alb\_certificate\_domain\_name) | Provide The alb Certificate Domain name present in ACM with Issued status. | `string` | n/a | yes |
| <a name="input_alb_egress_with_cidr_blocks"></a> [alb\_egress\_with\_cidr\_blocks](#input\_alb\_egress\_with\_cidr\_blocks) | List of egress rules to create by name | `list(map(string))` | n/a | yes |
| <a name="input_alb_ingress_with_cidr_blocks"></a> [alb\_ingress\_with\_cidr\_blocks](#input\_alb\_ingress\_with\_cidr\_blocks) | List of ingress rules to create where 'cidr\_blocks' is used | `list(map(string))` | n/a | yes |
| <a name="input_alb_name"></a> [alb\_name](#input\_alb\_name) | Provide The name for ALB. This name must be unique within your AWS account, can have a maximum of 32 characters, must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen | `string` | n/a | yes |
| <a name="input_alb_sg_description"></a> [alb\_sg\_description](#input\_alb\_sg\_description) | Security Group for ALB | `string` | n/a | yes |
| <a name="input_asg_ami_id"></a> [asg\_ami\_id](#input\_asg\_ami\_id) | AMI ID for the ASG Launch Template | `string` | n/a | yes |
| <a name="input_asg_desired_size"></a> [asg\_desired\_size](#input\_asg\_desired\_size) | Desired Size for the ASG | `number` | n/a | yes |
| <a name="input_asg_egress_with_cidr_blocks"></a> [asg\_egress\_with\_cidr\_blocks](#input\_asg\_egress\_with\_cidr\_blocks) | List of egress rules to create by name | `list(map(string))` | n/a | yes |
| <a name="input_asg_ingress_with_cidr_blocks"></a> [asg\_ingress\_with\_cidr\_blocks](#input\_asg\_ingress\_with\_cidr\_blocks) | List of ingress rules to create where 'cidr\_blocks' is used | `list(map(string))` | n/a | yes |
| <a name="input_asg_instance_ebs_optimized"></a> [asg\_instance\_ebs\_optimized](#input\_asg\_instance\_ebs\_optimized) | If enabled, the instances launched by the ASG will be EBS optimized | `bool` | n/a | yes |
| <a name="input_asg_instance_type"></a> [asg\_instance\_type](#input\_asg\_instance\_type) | Instance type for the ASG Launch Template | `string` | n/a | yes |
| <a name="input_asg_key_name"></a> [asg\_key\_name](#input\_asg\_key\_name) | Key Pair used for SSH to ASG instances | `string` | n/a | yes |
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | Maximum Size for the ASG | `number` | n/a | yes |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | Minimum Size for the ASG | `number` | n/a | yes |
| <a name="input_asg_sg_description"></a> [asg\_sg\_description](#input\_asg\_sg\_description) | Security Group for instances created by the ASG | `string` | n/a | yes |
| <a name="input_asg_volume_mapping"></a> [asg\_volume\_mapping](#input\_asg\_volume\_mapping) | EBS Volume mappings for ASG | `list(any)` | n/a | yes |
| <a name="input_bastion_egress_with_cidr_blocks"></a> [bastion\_egress\_with\_cidr\_blocks](#input\_bastion\_egress\_with\_cidr\_blocks) | List of egress rules to create by name | `list(map(string))` | n/a | yes |
| <a name="input_bastion_ingress_with_cidr_blocks"></a> [bastion\_ingress\_with\_cidr\_blocks](#input\_bastion\_ingress\_with\_cidr\_blocks) | List of ingress rules to create where 'cidr\_blocks' is used | `list(map(string))` | n/a | yes |
| <a name="input_bastion_instance_type"></a> [bastion\_instance\_type](#input\_bastion\_instance\_type) | Instance Type used by the Bastion Host | `string` | n/a | yes |
| <a name="input_bastion_sg_description"></a> [bastion\_sg\_description](#input\_bastion\_sg\_description) | Security Group for instances created by the Bastion Host | `string` | n/a | yes |
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | Whether Amazon S3 should block public ACLs for this bucket. | `bool` | n/a | yes |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | Whether Amazon S3 should block public bucket policies for this bucket. | `bool` | n/a | yes |
| <a name="input_client_name"></a> [client\_name](#input\_client\_name) | Client Name | `string` | n/a | yes |
| <a name="input_control_object_ownership"></a> [control\_object\_ownership](#input\_control\_object\_ownership) | Whether to manage S3 Bucket Ownership Controls on this bucket. | `bool` | n/a | yes |
| <a name="input_create_alb_sg"></a> [create\_alb\_sg](#input\_create\_alb\_sg) | Whether to create security group for Application Load Balancer | `bool` | n/a | yes |
| <a name="input_create_asg_iam_instance_profile"></a> [create\_asg\_iam\_instance\_profile](#input\_create\_asg\_iam\_instance\_profile) | If enabled, creates instance profiles for the instances launched by the ASG | `bool` | n/a | yes |
| <a name="input_create_asg_sg"></a> [create\_asg\_sg](#input\_create\_asg\_sg) | Whether to create security group for ASG | `bool` | n/a | yes |
| <a name="input_create_bastion_sg"></a> [create\_bastion\_sg](#input\_create\_bastion\_sg) | Whether to create security group for Bastion Host | `bool` | n/a | yes |
| <a name="input_create_db_subnet_group"></a> [create\_db\_subnet\_group](#input\_create\_db\_subnet\_group) | Determines whether to create the database subnet group or use existing | `bool` | `true` | no |
| <a name="input_create_igw"></a> [create\_igw](#input\_create\_igw) | Should be true if you want to create IGW | `bool` | n/a | yes |
| <a name="input_create_rds_sg"></a> [create\_rds\_sg](#input\_create\_rds\_sg) | Whether to create security group for ASG | `bool` | n/a | yes |
| <a name="input_create_s3_bucket"></a> [create\_s3\_bucket](#input\_create\_s3\_bucket) | Controls if S3 bucket should be created | `bool` | n/a | yes |
| <a name="input_create_sqs"></a> [create\_sqs](#input\_create\_sqs) | Whether to create SQS or not. | `bool` | n/a | yes |
| <a name="input_enable_asg_monitoring"></a> [enable\_asg\_monitoring](#input\_enable\_asg\_monitoring) | Enables monitoring for the ASG | `bool` | n/a | yes |
| <a name="input_enable_content_based_deduplication"></a> [enable\_content\_based\_deduplication](#input\_enable\_content\_based\_deduplication) | Should be true to enables content-based deduplication for FIFO queues. | `bool` | n/a | yes |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | If `true`, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. | `bool` | n/a | yes |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | Should be true if you want to provision NAT Gateways for each of your private networks | `bool` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment Name | `string` | n/a | yes |
| <a name="input_ignore_public_acls"></a> [ignore\_public\_acls](#input\_ignore\_public\_acls) | Whether Amazon S3 should ignore public ACLs for this bucket. | `bool` | n/a | yes |
| <a name="input_internal"></a> [internal](#input\_internal) | If true, the LB will be internal. | `bool` | n/a | yes |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | The type of IP addresses used by the subnets for your load balancer. The possible values are `ipv4` and `dualstack` | `string` | n/a | yes |
| <a name="input_listner_rule_https443_sync"></a> [listner\_rule\_https443\_sync](#input\_listner\_rule\_https443\_sync) | value | `any` | n/a | yes |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | The type of load balancer to create. Possible values are `application`, `gateway`, or `network`. The default value is `application` | `string` | n/a | yes |
| <a name="input_max_message_size"></a> [max\_message\_size](#input\_max\_message\_size) | The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB) | `number` | n/a | yes |
| <a name="input_message_retention_seconds"></a> [message\_retention\_seconds](#input\_message\_retention\_seconds) | The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days) default valu is 4days | `number` | n/a | yes |
| <a name="input_object_ownership"></a> [object\_ownership](#input\_object\_ownership) | Object ownership. Valid values: BucketOwnerEnforced, BucketOwnerPreferred or ObjectWriter. 'BucketOwnerEnforced': ACLs are disabled, and the bucket owner automatically owns and has full control over every object in the bucket. 'BucketOwnerPreferred': Objects uploaded to the bucket change ownership to the bucket owner if the objects are uploaded with the bucket-owner-full-control canned ACL. 'ObjectWriter': The uploading account will own the object if the object is uploaded with the bucket-owner-full-control canned ACL. | `string` | n/a | yes |
| <a name="input_one_nat_gateway_per_az"></a> [one\_nat\_gateway\_per\_az](#input\_one\_nat\_gateway\_per\_az) | Should be true if you want only one NAT Gateway per availability zone and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `azs` | `bool` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | A list of private subnets inside the VPC | `list(string)` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | A list of public subnets inside the VPC | `list(string)` | n/a | yes |
| <a name="input_rds_aurora_allow_major_version_upgrade"></a> [rds\_aurora\_allow\_major\_version\_upgrade](#input\_rds\_aurora\_allow\_major\_version\_upgrade) | Enable to allow major engine version upgrades when changing engine versions. Defaults to `false` | `bool` | n/a | yes |
| <a name="input_rds_aurora_apply_immediately"></a> [rds\_aurora\_apply\_immediately](#input\_rds\_aurora\_apply\_immediately) | Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. Default is `false` | `bool` | n/a | yes |
| <a name="input_rds_aurora_enabled_cloudwatch_logs_exports"></a> [rds\_aurora\_enabled\_cloudwatch\_logs\_exports](#input\_rds\_aurora\_enabled\_cloudwatch\_logs\_exports) | Set of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: `audit`, `error`, `general`, `slowquery`, `postgresql` | `list(string)` | n/a | yes |
| <a name="input_rds_aurora_engine"></a> [rds\_aurora\_engine](#input\_rds\_aurora\_engine) | The name of the database engine to be used for this DB cluster. Defaults to `aurora`. Valid Values: `aurora`, `aurora-mysql`, `aurora-postgresql` | `string` | `null` | no |
| <a name="input_rds_aurora_engine_mode"></a> [rds\_aurora\_engine\_mode](#input\_rds\_aurora\_engine\_mode) | The database engine mode. Valid values: `global`, `multimaster`, `parallelquery`, `provisioned`, `serverless`. Defaults to: `provisioned` | `string` | `"provisioned"` | no |
| <a name="input_rds_aurora_engine_version"></a> [rds\_aurora\_engine\_version](#input\_rds\_aurora\_engine\_version) | The database engine version. Updating this argument results in an outage | `string` | `null` | no |
| <a name="input_rds_aurora_instance_class"></a> [rds\_aurora\_instance\_class](#input\_rds\_aurora\_instance\_class) | Instance type to use at master instance. Note: if `autoscaling_enabled` is `true`, this will be the same instance class used on instances created by autoscaling | `string` | `""` | no |
| <a name="input_rds_aurora_manage_master_user_password"></a> [rds\_aurora\_manage\_master\_user\_password](#input\_rds\_aurora\_manage\_master\_user\_password) | Set to true to allow RDS to manage the master user password in Secrets Manager. Cannot be set if `master_password` is provided | `bool` | `true` | no |
| <a name="input_rds_aurora_master_username"></a> [rds\_aurora\_master\_username](#input\_rds\_aurora\_master\_username) | Username for the master DB user. Required unless `snapshot_identifier` or `replication_source_identifier` is provided or unless a `global_cluster_identifier` is provided when the cluster is the secondary cluster of a global database | `string` | `null` | no |
| <a name="input_rds_aurora_publicly_accessible"></a> [rds\_aurora\_publicly\_accessible](#input\_rds\_aurora\_publicly\_accessible) | Determines whether instances are publicly accessible. Default `false` | `bool` | n/a | yes |
| <a name="input_rds_aurora_storage_encrypted"></a> [rds\_aurora\_storage\_encrypted](#input\_rds\_aurora\_storage\_encrypted) | Specifies whether the DB cluster is encrypted. The default is `true` | `bool` | n/a | yes |
| <a name="input_rds_egress_with_cidr_blocks"></a> [rds\_egress\_with\_cidr\_blocks](#input\_rds\_egress\_with\_cidr\_blocks) | List of egress rules to create by name | `list(map(string))` | n/a | yes |
| <a name="input_rds_sg_description"></a> [rds\_sg\_description](#input\_rds\_sg\_description) | Security Group for instances created by the ASG | `string` | n/a | yes |
| <a name="input_restrict_public_buckets"></a> [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | Whether Amazon S3 should restrict public bucket policies for this bucket. | `bool` | n/a | yes |
| <a name="input_server_side_encryption_configuration"></a> [server\_side\_encryption\_configuration](#input\_server\_side\_encryption\_configuration) | server side encryption configuration | `map(any)` | n/a | yes |
| <a name="input_single_nat_gateway"></a> [single\_nat\_gateway](#input\_single\_nat\_gateway) | Should be true if you want to provision a single shared NAT Gateway across all of your private networks | `bool` | n/a | yes |
| <a name="input_sns_email_subscriptions"></a> [sns\_email\_subscriptions](#input\_sns\_email\_subscriptions) | A map of subscription definitions to create | `any` | `null` | no |
| <a name="input_sqs_create_dlq"></a> [sqs\_create\_dlq](#input\_sqs\_create\_dlq) | Should be true if you want to create SQS dead letter queue | `bool` | n/a | yes |
| <a name="input_sqs_create_fifo_queue"></a> [sqs\_create\_fifo\_queue](#input\_sqs\_create\_fifo\_queue) | Should be true if you want to create fifo queue | `bool` | n/a | yes |
| <a name="input_sqs_sse_enabled"></a> [sqs\_sse\_enabled](#input\_sqs\_sse\_enabled) | Should  be true if you want to enable server side encription | `bool` | n/a | yes |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Map containing versioning configuration. | `map(string)` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | mention the cidr\_block range for the vpc | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->