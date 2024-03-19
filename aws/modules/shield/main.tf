resource "aws_shield_protection" "default" {
  count        = length(var.associated_arns)
  name         = "${var.name}"
  resource_arn = "${var.associated_arns[count.index]}"

  tags = var.tags
}