# AWS Backup Terraform Module

This Terraform module is designed to manage AWS Backups for an Amazon Aurora cluster, including the capability to copy backups to a different region for disaster recovery purposes.

## Usage

### Basic Example

```hcl
module "aws_backup" {
  source              = "../../../../modules/backup"
  backup_vault_name   = "my-vault"
  backup_plan_name    = "aurora-backup-plan"
  target_backup_resource_arn  = "arn:aws:rds:us-east-1:123456789012:cluster:my-aurora-cluster"
  backup_rule_name    = "daily-backup"
  schedule            = "cron(0 12 * * ? *)"
  start_window        = ""
  completion_window   = ""
  recovery_point_tags = {
    "Project" = "MyProject"
  }
  delete_after       = ""
  destination_vault_arn = module.destination_vault_aws_backup.arn
  backup_selection_name = ""
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
