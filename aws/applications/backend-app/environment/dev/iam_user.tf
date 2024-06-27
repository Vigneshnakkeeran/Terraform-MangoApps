module "iam_user" {
  source = "../../../../modules/IAM/iam_user"

  name = "terraform_test_user01"

  create_iam_user_login_profile = false
  create_iam_access_key         = false
  iam_access_key_status         = "Inactive"
}

module "iam_group_with_custom_policies" {
  source = "../../../../modules/IAM/iam-group-with-policies"

  name = "ComoonAWSPermissions_test01"
  attach_iam_self_management_policy = false

  group_users = [
    module.iam_user.iam_user_name
  ]

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonElasticTranscoder_FullAccess",
    "arn:aws:iam::aws:policy/AmazonPollyFullAccess",
    "arn:aws:iam::aws:policy/AmazonSNSFullAccess",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonTranscribeFullAccess",
    "arn:aws:iam::aws:policy/TranslateFullAccess"
  ]

  custom_group_policies = [
    {
      name   = "AllowBucketVersioning_01"
      policy = data.aws_iam_policy_document.AllowBucketVersioning.json
    },
    {
      name   = "AmazonElasticTranscoderFullAccess-ComoonAWSPermissions_01"
      policy = data.aws_iam_policy_document.ComoonAWSPermissions.json
    }
  ]
}

######################
# IAM policy 
######################
data "aws_iam_policy_document" "AllowBucketVersioning" {
  statement {
    actions = [
        "s3:GetBucketVersioning",
        "s3:ListBucketVersions",
        "s3:PutBucketVersioning"
    ]

    resources = ["arn:aws:s3:::*"]
  }
}

data "aws_iam_policy_document" "ComoonAWSPermissions" {
  statement {
    actions = [
        "elastictranscoder:*",
        "cloudfront:*",
        "s3:List*",
        "s3:Put*",
        "s3:Get*",
        "s3:*MultipartUpload*",
        "iam:CreateRole",
        "iam:GetRolePolicy",
        "iam:PassRole",
        "iam:PutRolePolicy",
        "iam:List*",
        "sns:CreateTopic",
        "sns:List*"
    ]

    resources = ["*"]
  }
}