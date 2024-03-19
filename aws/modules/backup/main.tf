resource "aws_backup_vault" "example" {
  name        = "example_backup_vault"
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
      delete_after = 35
    }
  }
}

resource "aws_backup_selection" "main" {
  iam_role_arn = "arn:aws:iam::123456789012:role/service-role/AWSBackupDefaultServiceRole"
  plan_id      = aws_backup_plan.main.id
  name         = "aurora-cluster-selection"

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "aws:backup:source-resource"
    value = var.aurora_cluster_arn
  }
}
