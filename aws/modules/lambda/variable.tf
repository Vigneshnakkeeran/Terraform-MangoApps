variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "runtime" {
  description = "The runtime environment for the Lambda function"
  type        = string
}

variable "aws_region" {
  description = "AWS region for the Lambda function."
  type        = string
  default = "us-west-2"
}

variable "aws_incoming_bucket" {
  description = "S3 bucket name for incoming files."
  type        = string
}

variable "debug_mode" {
  description = "Debug mode toggle for the Lambda function."
  type        = string
  default     = "false"  # Assuming a default value of "false"
}

variable "handler" {
  description = "The function entrypoint in your code"
  type        = string
}

variable "file_type" {
  description = "The function entrypoint in your code"
  type        = string
  default =   "zip"
}
variable "role" {
  description = "The ARN of the IAM role that Lambda assumes when it executes your function"
  type        = string
}

variable "source_path" {
  description = "The absolute path to a local file or directory containing your Lambda source code"
  type        = any # string | list(string | map(any))
  default     = null
}

variable "layer_name" {
  description = "The absolute path to a local file or directory containing your Lambda source code"
  type        = string # string | list(string | map(any))
  default     = null
}

variable "lambda_layer_path" {
  description = "The absolute path to a local file or directory containing your Lambda source code"
  type        = string # string | list(string | map(any))
  default     = null
}

variable "memory_size" {
  description = "Memory size"
  type        = string
}

variable "ephemeral_storage_size" {
  description = "storage size"
  type        = string
}
