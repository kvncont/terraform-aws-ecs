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

variable "container_definitions" {
  description = "The container definitions for the task"
  type = list(object({
    name   = string
    image  = optional(string, "nginx:latest")
    cpu    = optional(number, 256)
    memory = optional(number, 512)
    portMappings = optional(list(object({
      containerPort = number
      hostPort      = number
      protocol      = optional(string, "tcp")
      })), [
      {
        containerPort = 80
        hostPort      = 80
        protocol      = "tcp"
      }
    ])
    essential = optional(bool, true)
    environment = optional(list(object({
      name  = string
      value = string
    })), [])
    mountPoints = optional(list(object({
      sourceVolume  = string
      containerPath = string
      readOnly      = bool
    })), [])
    volumesFrom = optional(list(object({
      sourceContainer = string
      readOnly        = bool
    })), [])
    logConfiguration = optional(object({
      logDriver = string
      options   = map(string)
    }))
    systemControls = optional(list(object({
      namespace = string
      value     = string
    })), [])
  }))
}

variable "gh_repo" {
  description = "The GitHub repository to use"
  type        = string
}

variable "gh_repo_environment" {
  description = "The environments to create in the GitHub repository"
  type        = string
}
