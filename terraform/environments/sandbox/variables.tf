variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "platform-engineering-module-test-058264480534"
}
variable "sender_email" {
  description = "Verified SES sender address"
  type        = string
}

variable "recipient_email" {
  description = "Notification recipient address"
  type        = string
}