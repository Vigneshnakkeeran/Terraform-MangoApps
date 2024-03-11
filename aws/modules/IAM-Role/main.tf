resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_policy" "custom" {
  name   = var.custom_policy_name
  policy = var.custom_policy
}

resource "aws_iam_role_policy_attachment" "custom_policy_attach" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.custom.arn
}

resource "aws_iam_role_policy_attachment" "managed_policy_attach" {
  for_each = toset(var.managed_policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = each.value
}
