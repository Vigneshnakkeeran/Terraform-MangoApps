resource "aws_ssm_parameter" "this" {
  for_each = var.ssm_parameters

  name        = each.value["name"]
  description = each.value["description"]
  type        = each.value["type"]
  value       = each.value["value"]
}

resource "aws_ssm_document" "this" {
  for_each = var.ssm_documents

  name          = each.value["name"]
  document_type = each.value["document_type"]
  document_format = each.value["document_format"]
  content       = each.value["content"]
}

resource "aws_ssm_maintenance_window" "this" {
  for_each = var.ssm_maintenance_windows

  name               = each.value["name"]
  schedule           = each.value["schedule"]
  duration           = each.value["duration"]
  cutoff             = each.value["cutoff"]
  allow_unassociated_targets = each.value["allow_unassociated_targets"]
}

resource "aws_ssm_maintenance_window_task" "this" {
  for_each = var.ssm_maintenance_window_tasks

  window_id       = aws_ssm_maintenance_window.this[each.value["window_id"]].id
  service_role_arn = aws_iam_role.example.arn
  task_arn           = aws_ssm_document.this[each.value["task_arn"]].arn
  task_type          = each.value["task_type"]

  task_invocation_parameters {
    automation_parameters {
      document_version = each.value["document_version"]
    }
  }
}

resource "aws_iam_role" "example" {
  name               = "AWS-SystemsManager-MaintenanceWindowRole"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": {
        "Service": "ssm.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "example" {
  name   = "AWS-SystemsManager-MaintenanceWindowPolicy"
  role   = aws_iam_role.example.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ssm:GetAutomationExecution",
          "ssm:GetParameters",
          "ssm:ListCommands",
          "ssm:SendCommand",
          "ssm:StartAutomationExecution",
          "ssm:PutParameter",
          "iam:PassRole",
          "ssm:DeleteParameter",
          "ssm:DescribeParameters",
          "lambda:InvokeFunction",
          "ssm:DescribeDocumentParameters",
          "ec2:CreateImage",
          "ssm:GetParameter",
          "ssm:DeleteParameters",
          "ec2:DescribeImages"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "lambda:InvokeFunction"
        ],
        "Resource": [
          "arn:aws:lambda:*:*:function:SSM*",
          "arn:aws:lambda:*:*:function:*:SSM*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
          "states:DescribeExecution",
          "states:StartExecution"
        ],
        "Resource": [
          "arn:aws:states:*:*:stateMachine:SSM*",
          "arn:aws:states:*:*:execution:SSM*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
          "resource-groups:ListGroups",
          "resource-groups:ListGroupResources"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "tag:GetResources"
        ],
        "Resource": "*"
      }
    ]
  })
}

