variable "region" {
  description = "The AWS region to deploy to"
  type        = string
}

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

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "az_count" {
  description = "The number of availability zones to use"
  type        = number
  default     = 2
}

variable "app_name" {
  description = "The name of the application"
  type        = string
  validation {
    condition     = can(regex("^([a-z0-9]+-)*[a-z0-9]+$", var.app_name))
    error_message = "The app_name must be in kebab-case (e.g., my-app-name)."
  }
}

variable "app_port" {
  description = "The port on which the application will run"
  type        = number
}

variable "app_count" {
  description = "The number of tasks to run"
  type        = number
  default     = 2
}

variable "app_health_check_path" {
  description = "The path to use for the health check"
  type        = string
  default     = "/"
}

variable "fargate_cpu" {
  description = "The amount of CPU to allocate for the Fargate task"
  type        = number
  default     = 512
}

variable "fargate_memory" {
  description = "The amount of memory to allocate for the Fargate task"
  type        = number
  default     = 1024
}

variable "gh_repo" {
  description = "The GitHub repository to use"
  type        = string
}

variable "gh_repo_environment" {
  description = "The environments to create in the GitHub repository"
  type        = string
}
