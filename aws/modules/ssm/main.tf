resource "aws_ssm_parameter" "this" {
  name        = var.parameter_name
  type        = var.parameter_type
  value       = var.parameter_value
  description = var.parameter_description
}

resource "aws_ssm_document" "this" {
  name          = var.document_name
  document_type = "Automation"
  content       = var.document_content
  document_format        = "YAML"
}

resource "aws_ssm_maintenance_window" "this" {
  name                 = var.window_name
  schedule             = var.window_schedule
  schedule_timezone    = var.schedule_timezone
  duration             = var.window_duration
  cutoff               = var.window_cutoff
  allow_unassociated_targets = var.allow_unassociated_targets
  description          = var.window_description
}

resource "aws_ssm_maintenance_window_task" "this" {
  window_id            = aws_ssm_maintenance_window.this.id
  task_arn             = aws_ssm_document.this.arn
  service_role_arn     = var.ssm_maintenance_window_service_role_arn
  task_type            = var.task_type
  # priority             = var.task_priority
  # max_concurrency      = var.max_concurrency
  # max_errors           = var.max_errors  
  description          = var.task_description

  dynamic "task_invocation_parameters" {
    for_each = var.task_invocation_parameters

    content {
      automation_parameters {
        # document_version = var.document_version
        dynamic "parameter" {
          for_each = task_invocation_parameters.value.parameters

          content {
            name   = parameter.value.name
            values = parameter.value.values
          }
        }
      }
    }
  }
}