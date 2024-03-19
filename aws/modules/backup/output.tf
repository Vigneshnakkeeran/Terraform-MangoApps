output "backup_vault_name" {
  description = "The name of the backup vault."
  value       = aws_backup_vault.main.name
}

output "backup_plan_id" {
  description = "The ID of the backup plan."
  value       = aws_backup_plan.main.id
}
