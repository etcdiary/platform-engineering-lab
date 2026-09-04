variable "function_name" {
  description = "Lambda function name"
  type        = string
}

variable "runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "python3.13"
}

variable "handler" {
  description = "Lambda handler"
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "filename" {
  description = "Path to Lambda deployment package"
  type        = string
}

variable "timeout" {
  description = "Lambda timeout in seconds"
  type        = number
  default     = 10
}

variable "memory_size" {
  description = "Lambda memory size"
  type        = number
  default     = 256
}

variable "execution_role_arn" {
  description = "ARN of the Lambda execution role"
  type        = string
}
variable "environment_variables" {
  description = "Environment variables to set on the Lambda function"
  type        = map(string)
  default     = {}
}