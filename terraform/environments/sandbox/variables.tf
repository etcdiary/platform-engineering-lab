variable "aws_region" {
  description = "AWS region for the environment"
  type        = string
  default     = "eu-west-2"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "sandbox"
}