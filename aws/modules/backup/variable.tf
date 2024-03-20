variable "backup_vault_name" {
  description = "The name of the backup vault."
  type        = string
}

variable "backup_plan_name" {
  description = "The name of the backup plan."
  type        = string
}

variable "aurora_cluster_arn" {
  description = "The ARN of the Aurora cluster to back up."
  type        = string
}

variable "backup_rule_name" {
  description = "The name of the backup rule."
  type        = string
}

variable "destination_vault_arn" {
  description = "The AWS region to copy the backups to."
  type        = string
}

variable "copy_retention" {
  description = "The number of days to retain the copied backups in the destination region."
  default     = 30
  type        = number
}


variable "schedule" {
  description = "A CRON expression specifying when to perform the backup."
  type        = string
}

variable "start_window" {
  description = "The amount of time in minutes after a backup is scheduled before the backup job is canceled if it doesn't start successfully."
  default     = 60
  type        = number
}

variable "completion_window" {
  description = "The amount of time in minutes after a backup starts that it must complete or it is canceled by AWS Backup."
  default     = 120
  type        = number
}

variable "recovery_point_tags" {
  description = "Metadata that you can assign to help organize the resources that you create."
  type        = map(string)
  default     = {}
}
