variable "bus_name" {
  description = "Name of the custom EventBridge bus"
  type        = string
}

variable "queue_name" {
  description = "Name of the SQS queue that receives matched events"
  type        = string
}

variable "event_source" {
  description = "Value matched in the EventBridge rule's 'source' field"
  type        = string
}

variable "event_detail_type" {
  description = "Value matched in the EventBridge rule's 'detail-type' field"
  type        = string
}

variable "publisher_role_name" {
  description = "IAM role name of the Lambda that will publish events"
  type        = string
}
variable "consumer_role_name" {
  description = "IAM role name of the Lambda that will consume from the queue"
  type        = string
}

variable "consumer_lambda_arn" {
  description = "ARN of the Lambda function that consumes from the queue"
  type        = string
}

variable "ses_sender_identity_arn" {
  description = "ARN of the verified SES identity allowed to send"
  type        = string
}