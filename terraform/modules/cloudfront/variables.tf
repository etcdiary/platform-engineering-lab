variable "api_domain_name" {
  description = "API Gateway domain name (no https://, no path)"
  type        = string
}

variable "web_acl_arn" {
  description = "ARN of the WAF Web ACL to attach"
  type        = string
}
variable "stage_name" {
  description = "API Gateway stage name to append as origin path"
  type        = string
}