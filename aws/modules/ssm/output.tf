output "ssm_parameter_id" {
  value = aws_ssm_parameter.this.id
}

output "ssm_document_name" {
  value = aws_ssm_document.this.name
}

output "ssm_maintenance_window_id" {
  value = aws_ssm_maintenance_window.this.id
}

output "ssm_maintenance_window_task_id" {
  value = aws_ssm_maintenance_window_task.this.id
}
