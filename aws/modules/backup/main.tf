resource "aws_backup_vault" "main" {
  name        = var.backup_vault_name
  kms_key_arn = aws_kms_key.example.arn
}

resource "aws_backup_plan" "main" {
  name = var.backup_plan_name

  rule {
    rule_name           = var.backup_rule_name
    target_vault_name   = aws_backup_vault.main.name
    schedule            = var.schedule
    start_window        = var.start_window
    completion_window   = var.completion_window
    recovery_point_tags = var.recovery_point_tags

    lifecycle {
      delete_after = var.delete_after
    }

    copy_action {
      destination_vault_arn = var.destination_vault_arn
      lifecycle {
        delete_after = var.copy_retention
      }
    }
  }
}

resource "aws_backup_selection" "example" {
  iam_role_arn = "arn:aws:iam::123456789012:role/service-role/AWSBackupDefaultServiceRole"
  name         = var.backup_selection_name
  plan_id      = aws_backup_plan.main.id

  resources = var.target_backup_resource_arn
}
