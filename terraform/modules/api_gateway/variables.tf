variable "api_name" {
  description = "Name of the HTTP API"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "Invoke ARN of the target Lambda function"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the target Lambda function (for the resource-based policy)"
  type        = string
}

variable "route_key" {
  description = "Route, e.g. POST /notify"
  type        = string
  default     = "POST /notify"
}

variable "stage_name" {
  description = "API Gateway stage name"
  type        = string
  default     = "sandbox"
}