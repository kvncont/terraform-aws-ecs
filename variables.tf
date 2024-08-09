variable "region" {
  description = "The AWS region to deploy to"
  type = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type = string
}

variable "az_count" {
  description = "The number of availability zones to use"
  type        = number
  default     = 2
}

variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "app_image" {
  description = "The Docker image for the application"
  type        = string
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
  default     = 256
}

variable "fargate_memory" {
  description = "The amount of memory to allocate for the Fargate task"
  type        = number
  default     = 512
}
