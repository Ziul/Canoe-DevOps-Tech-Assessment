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
