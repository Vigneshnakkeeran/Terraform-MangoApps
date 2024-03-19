variable "associated_arns" {
  description = "List of ARNs to which AWS Shield is associated to."
  type = list(string)
  default = []
}

variable "name" {
  description = "Shield Name."
  type = string
  default = ""
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}
