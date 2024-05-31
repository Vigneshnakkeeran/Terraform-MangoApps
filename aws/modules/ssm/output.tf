output "ssm_parameters" {
  value = aws_ssm_parameter.this
}

output "ssm_documents" {
  value = aws_ssm_document.this
}

output "ssm_maintenance_windows" {
  value = aws_ssm_maintenance_window.this
}

output "ssm_maintenance_window_tasks" {
  value = aws_ssm_maintenance_window_task.this
}
