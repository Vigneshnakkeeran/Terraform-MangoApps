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
  task_invocation_parameters {
    automation_parameters {
       # document_version = var.document_version
      parameter {
        name   = "InstanceId"
        values = ["i-08de8a3cadde7e35c"]
      }
      parameter {
        name   = "NoReboot"
        values = ["true"] 
      }
      parameter {
        name   = "AutomationAssumeRole"
        values = ["arn:aws:iam::730335460835:role/ssm_automation_ami_creation"]
      }
      parameter {
        name   = "ParameterName"
        values = ["cloudifyops_image_id"]
      }      
      parameter {
        name   = "ParameterValue"
        values = ["ami-0dcd9e2f1f1d58966"]
      }
      parameter {
        name   = "LambdaUpdateLT"
        values = ["update_launch_template"]
      }      
      parameter {
        name   = "LambdaDeleteAMI"
        values = ["delete_custom_images"]
      }
    }
  }
}

# resource "aws_iam_role" "example" {
#   name               = "AWS-SystemsManager-MaintenanceWindowRole"
#   assume_role_policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [{
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "ssm.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }]
#   })
# }

# resource "aws_iam_role_policy" "example" {
#   name   = "AWS-SystemsManager-MaintenanceWindowPolicy"
#   role   = aws_iam_role.example.id
#   policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Effect": "Allow",
#         "Action": [
#           "ssm:GetAutomationExecution",
#           "ssm:GetParameters",
#           "ssm:ListCommands",
#           "ssm:SendCommand",
#           "ssm:StartAutomationExecution",
#           "ssm:PutParameter",
#           "iam:PassRole",
#           "ssm:DeleteParameter",
#           "ssm:DescribeParameters",
#           "lambda:InvokeFunction",
#           "ssm:DescribeDocumentParameters",
#           "ec2:CreateImage",
#           "ssm:GetParameter",
#           "ssm:DeleteParameters",
#           "ec2:DescribeImages"
#         ],
#         "Resource": "*"
#       },
#       {
#         "Effect": "Allow",
#         "Action": [
#           "lambda:InvokeFunction"
#         ],
#         "Resource": [
#           "arn:aws:lambda:*:*:function:SSM*",
#           "arn:aws:lambda:*:*:function:*:SSM*"
#         ]
#       },
#       {
#         "Effect": "Allow",
#         "Action": [
#           "states:DescribeExecution",
#           "states:StartExecution"
#         ],
#         "Resource": [
#           "arn:aws:states:*:*:stateMachine:SSM*",
#           "arn:aws:states:*:*:execution:SSM*"
#         ]
#       },
#       {
#         "Effect": "Allow",
#         "Action": [
#           "resource-groups:ListGroups",
#           "resource-groups:ListGroupResources"
#         ],
#         "Resource": "*"
#       },
#       {
#         "Effect": "Allow",
#         "Action": [
#           "tag:GetResources"
#         ],
#         "Resource": "*"
#       }
#     ]
#   })
# }

