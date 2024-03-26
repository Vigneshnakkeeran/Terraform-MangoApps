# output "lambda_execution_role" {
#   description = "The ARN of the IAM role created for Lambda execution"
#   value       = aws_iam_role.lambda_execution_role.arn
# }

output "lambda_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.my_lambda.arn
}

output "function_arn" {
  value = aws_lambda_function.my_lambda.arn
}
