variable "role_name" {
  description = "The name of the IAM role."
  type        = string
}

variable "assume_role_policy" {
  description = "The policy that grants an entity permission to assume the role."
  type        = string
}

variable "managed_policy_arns" {
  description = "A list of ARNs of AWS managed policies you want to attach."
  type        = list(string)
  default     = []
}

variable "custom_policy_name" {
  description = "The name of the custom policy."
  type        = string
}

variable "custom_policy" {
  description = "The JSON policy document for the custom policy."
  type        = string
}
