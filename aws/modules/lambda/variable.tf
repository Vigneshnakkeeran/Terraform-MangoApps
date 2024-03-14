variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "runtime" {
  description = "The runtime environment for the Lambda function"
  type        = string
}

variable "handler" {
  description = "The function entrypoint in your code"
  type        = string
}

variable "role" {
  description = "The ARN of the IAM role that Lambda assumes when it executes your function"
  type        = string
}

variable "memory_size" {
  description = "Memory size"
  type        = string
}

variable "ephemeral_storage_size" {
  description = "storage size"
  type        = string
}
