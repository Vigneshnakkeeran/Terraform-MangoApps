variable "parameter_name" {
  description = "The name of the SSM parameter."
  type        = string
}

variable "parameter_type" {
  description = "The type of the SSM parameter."
  type        = string
}


# variable "create_policy" {
#   description = "The type of the SSM parameter."
#   type        = bool
#   default = true
# }

# variable "create_role" {
#   description = "name of enviroment."
#   type        = bool
#   default = true
# }

variable "document_version" {
  description = "name of enviroment."
  type        = string
  default = "1"
}

variable "parameter_value" {
  description = "The value of the SSM parameter."
  type        = string
}

variable "parameter_description" {
  description = "The description of the SSM parameter."
  type        = string
  default     = ""
}

variable "document_name" {
  description = "The name of the SSM document."
  type        = string
}

variable "document_content" {
  description = "The content of the SSM document in YAML format."
  type        = string
}

variable "window_name" {
  description = "The name of the maintenance window."
  type        = string
}

variable "window_schedule" {
  description = "The schedule of the maintenance window in cron or rate expression."
  type        = string
}

variable "window_duration" {
  description = "The duration of the maintenance window in hours."
  type        = number
}

variable "window_cutoff" {
  description = "The number of hours before the end of the maintenance window that no new tasks are scheduled."
  type        = number
}

variable "allow_unassociated_targets" {
  description = "Whether targets must be registered with the maintenance window before tasks can be defined for those targets."
  type        = bool
  default     = false
}

variable "window_description" {
  description = "The description of the maintenance window."
  type        = string
  default     = ""
}

# variable "task_targets" {
#   description = "The targets of the maintenance window task."
#   type        = list(object({
#     Key    = string
#     Values = list(string)
#   }))
# }

# variable "task_arn" {
#   description = "The ARN of the task to execute."
#   type        = string
# }

# variable "service_role_arn" {
#   description = "The ARN of the IAM role to use to execute the task."
#   type        = string
# }

variable "task_type" {
  description = "The type of task being registered."
  type        = string
}

# variable "task_priority" {
#   description = "The priority of the task in the maintenance window."
#   type        = number
# }

# variable "max_concurrency" {
#   description = "The maximum number of targets this task can be run for in parallel."
#   type        = string
# }

# variable "max_errors" {
#   description = "The maximum number of errors allowed before this task stops being scheduled."
#   type        = string
# }

variable "task_description" {
  description = "The description of the maintenance window task."
  type        = string
  default     = ""
}
