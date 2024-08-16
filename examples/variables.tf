variable "aws_access_key_id" {
  description = "The AWS access key ID"
  type        = string
}

variable "aws_secret_access_key" {
  description = "The AWS secret access key"
  type        = string
}

variable "assume_role_arn" {
  description = "The ARN of the role to assume"
  type        = string
}
