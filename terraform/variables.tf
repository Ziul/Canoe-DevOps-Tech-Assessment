variable "name" {
  description = "Service name. It'll be used in several places"
  type        = string
  default     = "api-service"
}
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cpu" {
  description = "CPU available for the task"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "RAM memory available for the task"
  type        = string
  default     = "512"
}

variable "containerPort" {
    description = "Port where the applicatino is running in the container"
    type = number
    default = 8000
}

variable "tags" {
  description = "A map of tags to use on all resources"
  type        = map(string)
  default     = {
  }
}

locals {
  default_tags = {
    service = var.name
  }

  tags = merge(local.default_tags, var.tags)
}

variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running"
  type        = number
  default     = 1
}

variable "ecs_service_deployment_maximum_percent" {
  description = "The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment"
  type        = number
  default     = 200
}

variable "ecs_service_deployment_minimum_healthy_percent" {
  description = "The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment"
  type        = number
  default     = 50
}
