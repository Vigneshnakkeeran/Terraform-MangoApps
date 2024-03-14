# module "iam_role_with_policies" {
#   source = "./../../../../aws/modules/IAM-Role"

#   role_name           = "example-role"
#   assume_role_policy  = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   })
#   managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
#   custom_policy_name  = "example-custom-policy"
#   custom_policy       = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": "logs:CreateLogGroup",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

################### LAMBDA FUNCTION EXECUTION ROLE ####################

# module "lambda_execution_role" {
#   source = "./../../../../aws/modules/IAM-Role"
#   role_name           = "${var.lambda_function_name}_execution_role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#       },
#     ]
#   })
# }
#   managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
#   custom_policy_name  = "example-custom-policy"
#   custom_policy       = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": "logs:CreateLogGroup",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }


