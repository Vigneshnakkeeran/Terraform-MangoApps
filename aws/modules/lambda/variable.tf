variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}
variable "create" {
  description = "Controls whether resources should be created"
  type        = bool
  default     = true
}
variable "create_layer" {
  description = "Controls whether Lambda Layer resource should be created"
  type        = bool
  default     = false
}
variable "create_function" {
  description = "Controls whether Lambda Function resource should be created"
  type        = bool
  default     = true
}
# variable "lambda_permission_source_arn" {
#   description = "The name of the Lambda function"
#   type        = string
# }

# variable "lambda_permission_function_name" {
#   description = "The name of the Lambda function"
#   type        = string
# }
variable "runtime" {
  description = "The runtime environment for the Lambda function"
  type        = string
  default = "value"
}

# variable "layers" {
#   description = "The runtime environment for the Lambda function"
#   type        = list(string)
#   default = "value"
# }
# variable "layer_runtime" {
#   description = "The layer runtime environment for the Lambda function"
#   type        = list(string)
# }
variable "aws_region" {
  description = "AWS region for the Lambda function."
  type        = string
  default = "us-west-2"
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
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

variable "s3_bucket" {
  description = "s3 bucket name where the lambda code is"
  type        = any # string | list(string | map(any))
  default     = null
}

variable "s3_key_layer" {
  description = "s3 bucket name where the lambda code is"
  type        = any # string | list(string | map(any))
  default     = null
}
variable "s3_key_function_code" {
  description = "lambda function code s3 object name"
  type        = any # string | list(string | map(any))
  default     = null
}
variable "layer_name" {
  description = "The absolute path to a local file or directory containing your Lambda source code"
  type        = string # string | list(string | map(any))
  default     = null
}

# variable "lambda_layer_path" {
#   description = "The absolute path to a local file or directory containing your Lambda source code"
#   type        = string # string | list(string | map(any))
#   default     = null
# }

variable "memory_size" {
  description = "Memory size"
  type        = string
}

variable "ephemeral_storage_size" {
  description = "Amount of ephemeral storage (/tmp) in MB your Lambda Function can use at runtime. Valid value between 512 MB to 10,240 MB (10 GB)."
  type        = number
  default     = 512
}
