module "rds" {
  source = "../../../../modules/rds-aurora"
  name   = "${var.client_name}-${var.environment}-aurora01"
  allow_major_version_upgrade = var.rds_aurora_allow_major_version_upgrade
  apply_immediately           = var.rds_aurora_apply_immediately
  #backup_retention_period = ""
  database_name       = var.rds_db_name
  create_db_subnet_group = true
  db_subnet_group_name = "db-subnet-group"
  subnets              = module.vpc.private_subnets
  #delete_automated_backups = false
  #deletion_protection = false
  instance_class = var.rds_aurora_instance_class
  instances = {
    one   = {}
    # two   = {}
    # three = {}
  }
  engine                      = var.rds_aurora_engine
  engine_mode                 = var.rds_aurora_engine_mode
  engine_version              = var.rds_aurora_engine_version
  manage_master_user_password = var.rds_aurora_manage_master_user_password #Set to true to allow RDS to manage the master user password in Secrets Manager
  master_password             = data.aws_ssm_parameter.rds_aurora_parameter_password.value
  master_username             = var.rds_aurora_master_username
  storage_encrypted               = var.rds_aurora_storage_encrypted
  enabled_cloudwatch_logs_exports = var.rds_aurora_enabled_cloudwatch_logs_exports
  publicly_accessible             = var.rds_aurora_publicly_accessible
  vpc_security_group_ids          = [module.rds_security_group.security_group_id]
  create_security_group           = false
  skip_final_snapshot             = true
  tags = {
    Created_by = "Terraform"
    Client     = var.client_name
    Env        = var.environment
    Backup     = "True"
  }
}
