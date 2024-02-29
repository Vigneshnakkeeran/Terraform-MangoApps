# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_instance" "us-oregon-cloud02" {
  ami                                  = "ami-04377a4b42b31e8e5"
  associate_public_ip_address          = false
  availability_zone                    = "us-west-2a"
  disable_api_stop                     = false
  disable_api_termination              = true
  ebs_optimized                        = true
  get_password_data                    = false
  hibernation                          = false
  host_id                              = null
  host_resource_group_arn              = null
  iam_instance_profile                 = "ma-ec2-instance-role"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "r5a.2xlarge"
  ipv6_address_count                   = 0
  ipv6_addresses                       = []
  key_name                             = "maoregondefault"
  monitoring                           = false
  placement_group                      = null
  placement_partition_number           = 0
  private_ip                           = "172.30.3.167"
  secondary_private_ips                = []
  security_groups                      = []
  source_dest_check                    = true
  subnet_id                            = "subnet-00c5bc1c52d76a6c2"
  tags = {
    MaMajorVersion = "16"
    ManagedBy      = "SystemsManager"
    Name           = "us-oregon-cloud02"
  }
  tags_all = {
    MaMajorVersion = "16"
    ManagedBy      = "SystemsManager"
    Name           = "us-oregon-cloud02"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_base64            = null
  user_data_replace_on_change = null
  volume_tags                 = null
  vpc_security_group_ids      = ["sg-0e1f9f2af62ae9849"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    amd_sev_snp      = null
    core_count       = 4
    threads_per_core = 2
  }
  ebs_block_device {
    delete_on_termination = true
    device_name           = "/dev/sdb"
    encrypted             = false
    iops                  = 600
    kms_key_id            = null
    snapshot_id           = "snap-0131b83904fe8e954"
    tags                  = {}
    throughput            = 0
    volume_size           = 200
    volume_type           = "gp2"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "enabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 300
    kms_key_id            = null
    tags                  = {}
    throughput            = 0
    volume_size           = 100
    volume_type           = "gp2"
  }
}

# __generated__ by Terraform
resource "aws_instance" "us-oregon-cloud03" {
  ami                                  = "ami-04377a4b42b31e8e5"
  associate_public_ip_address          = false
  availability_zone                    = "us-west-2a"
  disable_api_stop                     = false
  disable_api_termination              = true
  ebs_optimized                        = true
  get_password_data                    = false
  hibernation                          = false
  host_id                              = null
  host_resource_group_arn              = null
  iam_instance_profile                 = "ma-ec2-instance-role"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "r5a.2xlarge"
  ipv6_address_count                   = 0
  ipv6_addresses                       = []
  key_name                             = "maoregondefault"
  monitoring                           = false
  placement_group                      = null
  placement_partition_number           = 0
  private_ip                           = "172.30.3.144"
  secondary_private_ips                = []
  security_groups                      = []
  source_dest_check                    = true
  subnet_id                            = "subnet-00c5bc1c52d76a6c2"
  tags = {
    MaMajorVersion = "16"
    ManagedBy      = "SystemsManager"
    Name           = "us-oregon-cloud03"
  }
  tags_all = {
    MaMajorVersion = "16"
    ManagedBy      = "SystemsManager"
    Name           = "us-oregon-cloud03"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_base64            = null
  user_data_replace_on_change = null
  volume_tags                 = null
  vpc_security_group_ids      = ["sg-0e1f9f2af62ae9849"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    amd_sev_snp      = null
    core_count       = 4
    threads_per_core = 2
  }
  ebs_block_device {
    delete_on_termination = true
    device_name           = "/dev/sdb"
    encrypted             = false
    iops                  = 600
    kms_key_id            = null
    snapshot_id           = "snap-0131b83904fe8e954"
    tags = {
      MaMajorVersion = "16"
      ManagedBy      = "SystemsManager"
      Name           = "us-oregon-cloud03"
    }
    throughput  = 0
    volume_size = 200
    volume_type = "gp2"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "enabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 300
    kms_key_id            = null
    tags = {
      MaMajorVersion = "16"
      ManagedBy      = "SystemsManager"
      Name           = "us-oregon-cloud03"
    }
    throughput  = 0
    volume_size = 100
    volume_type = "gp2"
  }
}

# __generated__ by Terraform
resource "aws_instance" "us-oregon-cloud13" {
  ami                                  = "ami-04377a4b42b31e8e5"
  associate_public_ip_address          = false
  availability_zone                    = "us-west-2a"
  disable_api_stop                     = false
  disable_api_termination              = true
  ebs_optimized                        = true
  get_password_data                    = false
  hibernation                          = false
  host_id                              = null
  host_resource_group_arn              = null
  iam_instance_profile                 = "ma-ec2-instance-role"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "m5a.xlarge"
  ipv6_address_count                   = 0
  ipv6_addresses                       = []
  key_name                             = "maoregondefault"
  monitoring                           = false
  placement_group                      = null
  placement_partition_number           = 0
  private_ip                           = "172.30.3.12"
  secondary_private_ips                = []
  security_groups                      = []
  source_dest_check                    = true
  subnet_id                            = "subnet-00c5bc1c52d76a6c2"
  tags = {
    MaMajorVersion = "16"
    ManagedBy      = "SystemsManager"
    Name           = "us-oregon-cloud13"
  }
  tags_all = {
    MaMajorVersion = "16"
    ManagedBy      = "SystemsManager"
    Name           = "us-oregon-cloud13"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_base64            = null
  user_data_replace_on_change = null
  volume_tags                 = null
  vpc_security_group_ids      = ["sg-0e1f9f2af62ae9849"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    amd_sev_snp      = null
    core_count       = 2
    threads_per_core = 2
  }
  ebs_block_device {
    delete_on_termination = true
    device_name           = "/dev/sdb"
    encrypted             = false
    iops                  = 600
    kms_key_id            = null
    snapshot_id           = "snap-0131b83904fe8e954"
    tags                  = {}
    throughput            = 0
    volume_size           = 200
    volume_type           = "gp2"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "enabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 300
    kms_key_id            = null
    tags                  = {}
    throughput            = 0
    volume_size           = 100
    volume_type           = "gp2"
  }
}

# __generated__ by Terraform
resource "aws_instance" "us-oregon-cloud21" {
  ami                                  = "ami-04377a4b42b31e8e5"
  associate_public_ip_address          = false
  availability_zone                    = "us-west-2a"
  disable_api_stop                     = false
  disable_api_termination              = true
  ebs_optimized                        = true
  get_password_data                    = false
  hibernation                          = false
  host_id                              = null
  host_resource_group_arn              = null
  iam_instance_profile                 = "ma-ec2-instance-role"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "r5a.2xlarge"
  ipv6_address_count                   = 0
  ipv6_addresses                       = []
  key_name                             = "maoregondefault"
  monitoring                           = false
  placement_group                      = null
  placement_partition_number           = 0
  private_ip                           = "172.30.3.11"
  secondary_private_ips                = []
  security_groups                      = []
  source_dest_check                    = true
  subnet_id                            = "subnet-00c5bc1c52d76a6c2"
  tags = {
    MaMajorVersion = "16"
    ManagedBy      = "SystemsManager"
    Name           = "us-oregon-cloud21"
  }
  tags_all = {
    MaMajorVersion = "16"
    ManagedBy      = "SystemsManager"
    Name           = "us-oregon-cloud21"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_base64            = null
  user_data_replace_on_change = null
  volume_tags                 = null
  vpc_security_group_ids      = ["sg-0e1f9f2af62ae9849"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    amd_sev_snp      = null
    core_count       = 4
    threads_per_core = 2
  }
  ebs_block_device {
    delete_on_termination = true
    device_name           = "/dev/sdb"
    encrypted             = false
    iops                  = 600
    kms_key_id            = null
    snapshot_id           = "snap-0131b83904fe8e954"
    tags                  = {}
    throughput            = 0
    volume_size           = 200
    volume_type           = "gp2"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "enabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 300
    kms_key_id            = null
    tags                  = {}
    throughput            = 0
    volume_size           = 100
    volume_type           = "gp2"
  }
}

# __generated__ by Terraform
resource "aws_instance" "us-oregon-cloud01" {
  ami                                  = "ami-04377a4b42b31e8e5"
  associate_public_ip_address          = false
  availability_zone                    = "us-west-2a"
  disable_api_stop                     = false
  disable_api_termination              = true
  ebs_optimized                        = true
  get_password_data                    = false
  hibernation                          = false
  host_id                              = null
  host_resource_group_arn              = null
  iam_instance_profile                 = "ma-ec2-instance-role"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "r5a.2xlarge"
  ipv6_address_count                   = 0
  ipv6_addresses                       = []
  key_name                             = "maoregondefault"
  monitoring                           = false
  placement_group                      = null
  placement_partition_number           = 0
  private_ip                           = "172.30.3.132"
  secondary_private_ips                = []
  security_groups                      = []
  source_dest_check                    = true
  subnet_id                            = "subnet-00c5bc1c52d76a6c2"
  tags = {
    MaMajorVersion = "16"
    ManagedBy      = "SystemsManager"
    Name           = "us-oregon-cloud01"
  }
  tags_all = {
    MaMajorVersion = "16"
    ManagedBy      = "SystemsManager"
    Name           = "us-oregon-cloud01"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_base64            = null
  user_data_replace_on_change = null
  volume_tags                 = null
  vpc_security_group_ids      = ["sg-0e1f9f2af62ae9849"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    amd_sev_snp      = null
    core_count       = 4
    threads_per_core = 2
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "enabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 300
    kms_key_id            = null
    tags = {
      MaMajorVersion = "16"
      ManagedBy      = "SystemsManager"
      Name           = "us-oregon-cloud01"
    }
    throughput  = 0
    volume_size = 100
    volume_type = "gp2"
  }
}

# __generated__ by Terraform
resource "aws_instance" "MaUJumpBox" {
  ami                                  = "ami-017fecd1353bcc96e"
  associate_public_ip_address          = true
  availability_zone                    = "us-west-2a"
  disable_api_stop                     = false
  disable_api_termination              = true
  ebs_optimized                        = false
  get_password_data                    = false
  hibernation                          = false
  host_id                              = null
  host_resource_group_arn              = null
  iam_instance_profile                 = "ma-ec2-instance-role"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"
  ipv6_address_count                   = 0
  ipv6_addresses                       = []
  key_name                             = "maoregondefault"
  monitoring                           = false
  placement_group                      = null
  placement_partition_number           = 0
  private_ip                           = "172.30.0.184"
  secondary_private_ips                = []
  security_groups                      = []
  source_dest_check                    = true
  subnet_id                            = "subnet-0e903bd4234f7095b"
  tags = {
    MaMajorVersion = "16"
    ManagedBy      = "SystemsManager"
    Name           = "MaUsJumpBox"
  }
  tags_all = {
    MaMajorVersion = "16"
    ManagedBy      = "SystemsManager"
    Name           = "MaUsJumpBox"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_base64            = null
  user_data_replace_on_change = null
  volume_tags                 = null
  vpc_security_group_ids      = ["sg-029231edeb8fc31e8"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    amd_sev_snp      = null
    core_count       = 1
    threads_per_core = 1
  }
  credit_specification {
    cpu_credits = "standard"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "enabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 100
    kms_key_id            = null
    tags = {
      MaMajorVersion = "16"
      ManagedBy      = "SystemsManager"
      Name           = "MaUsJumpBox"
    }
    throughput  = 0
    volume_size = 8
    volume_type = "gp2"
  }
}

# __generated__ by Terraform
resource "aws_instance" "us-oregon-cloud11" {
  ami                                  = "ami-04377a4b42b31e8e5"
  associate_public_ip_address          = false
  availability_zone                    = "us-west-2a"
  disable_api_stop                     = false
  disable_api_termination              = true
  ebs_optimized                        = true
  get_password_data                    = false
  hibernation                          = false
  host_id                              = null
  host_resource_group_arn              = null
  iam_instance_profile                 = "ma-ec2-instance-role"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "r5a.2xlarge"
  ipv6_address_count                   = 0
  ipv6_addresses                       = []
  key_name                             = "maoregondefault"
  monitoring                           = false
  placement_group                      = null
  placement_partition_number           = 0
  private_ip                           = "172.30.3.76"
  secondary_private_ips                = []
  security_groups                      = []
  source_dest_check                    = true
  subnet_id                            = "subnet-00c5bc1c52d76a6c2"
  tags = {
    MaMajorVersion = "16"
    ManagedBy      = "SystemsManager"
    Name           = "us-oregon-cloud11"
  }
  tags_all = {
    MaMajorVersion = "16"
    ManagedBy      = "SystemsManager"
    Name           = "us-oregon-cloud11"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_base64            = null
  user_data_replace_on_change = null
  volume_tags                 = null
  vpc_security_group_ids      = ["sg-0e1f9f2af62ae9849"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    amd_sev_snp      = null
    core_count       = 4
    threads_per_core = 2
  }
  ebs_block_device {
    delete_on_termination = true
    device_name           = "/dev/sdb"
    encrypted             = false
    iops                  = 600
    kms_key_id            = null
    snapshot_id           = "snap-0131b83904fe8e954"
    tags                  = {}
    throughput            = 0
    volume_size           = 200
    volume_type           = "gp2"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "enabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 300
    kms_key_id            = null
    tags                  = {}
    throughput            = 0
    volume_size           = 100
    volume_type           = "gp2"
  }
}
