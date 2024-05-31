module "ssm" {
  source = "./complete"

  ssm_parameters = {
    param1 = {
      name        = "ami_id"
      description = "Example parameter 1"
      type        = "SecureString"
      value       = "ami-02f0f3474e47134b3"
    }
  }

  ssm_documents = {
    doc1 = {
      name          = "test_document"
      document_type = "Automation"
      document_format = "YAML"
      content       = <<DOC
description: Creates a new Amazon Machine Image (AMI) from an Amazon EC2 instance.
schemaVersion: '0.3'
assumeRole: '{{ AutomationAssumeRole }}'
outputs:
  - createImage.ImageId
parameters:
  InstanceId:
    type: String
    description: '(Required) The ID of the Amazon EC2 instance.'
    default: i-0783178cbd4d088ae
  NoReboot:
    type: Boolean
    description: '(Optional) Do not reboot the instance before creating the image.'
    default: true
  AutomationAssumeRole:
    type: String
    description: '(Optional) The ARN of the role that allows Automation to perform the actions on your behalf.'
    default: 'arn:aws:iam::aws-account-id:role/ssm_automation_ami_creation'
  ParameterName:
    type: String
    description: '(Required) The name of the SSM parameter store value to update.'
    default: oregon_image_id
  ParameterValue:
    type: String
    description: '(Required) The new value to set for the SSM parameter store value.'
    default: ami-0dcd9e2f1f1d58966
  LambdaUpdateLT:
    type: String
    description: '(Optional) The new value to set for the SSM parameter store value.'
    default: update_launch_template
  LambdaDeleteAMI:
    type: String
    description: '(Optional) The new value to set for the SSM parameter store value.'
    default: delete_custom_images
mainSteps:
  - action: 'aws:invokeLambdaFunction'
    name: Deletelambda
    timeoutSeconds: 1200
    maxAttempts: 1
    onFailure: Abort
    inputs:
      FunctionName: '{{LambdaDeleteAMI}}'
  - name: createImage
    action: 'aws:createImage'
    timeoutSeconds: 2400
    onFailure: Abort
    inputs:
      InstanceId: '{{ InstanceId }}'
      ImageName: '{{ InstanceId }}_{{automation:EXECUTION_ID}}'
      NoReboot: '{{ NoReboot }}'
  - name: UpdateParameter
    action: 'aws:executeAwsApi'
    inputs:
      Service: ssm
      Api: PutParameter
      Name: '{{ ParameterName }}'
      Value: '{{ createImage.ImageId }}'
      Type: String
      Overwrite: true
  - action: 'aws:invokeLambdaFunction'
    name: InvokeLambdaFunction
    timeoutSeconds: 1200
    maxAttempts: 1
    onFailure: Abort
    inputs:
      FunctionName: '{{LambdaUpdateLT}}' 

DOC
    }
  }

  ssm_maintenance_windows = {
    window1 = {
      name                      = "ExampleMaintenanceWindow"
      schedule                  = "cron(0 2 ? * 5 *)"
      duration                  = 3
      cutoff                    = 1
      allow_unassociated_targets = false
    }
  }

  ssm_maintenance_window_tasks = {
    task1 = {
      task_type        = "AUTOMATION"
      document_version = "1"
    }
  }
}
