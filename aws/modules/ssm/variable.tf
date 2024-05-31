variable "region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "us-west-2"
}

variable "ssm_parameters" {
  description = "Map of SSM parameter configurations"
  type = map(object({
    name        = string
    description = string
    type        = string
    value       = string
  }))
}

variable "ssm_documents" {
  description = "Map of SSM document configurations"
  type = map(object({
    name          = string
    document_type = string
    document_format = string
    content       = string
  }))
}

variable "ssm_maintenance_windows" {
  description = "Map of SSM maintenance window configurations"
  type = map(object({
    name                      = string
    schedule                  = string
    duration                  = number
    cutoff                    = number
    allow_unassociated_targets = bool
  }))
}

variable "ssm_maintenance_window_tasks" {
  description = "Map of SSM maintenance window task configurations"
  type = map(object({
    task_type        = string
    document_version = string
  }))
}
