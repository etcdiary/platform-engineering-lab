provider "aws" {
  region              = "eu-west-2"
  allowed_account_ids = ["058264480534"]
}

module "notification_lambda" {
  source = "../../modules/lambda"

  function_name      = "platform-notification"
  filename           = "../../../lambda/notification/notification.zip"
  execution_role_arn = module.notification_iam.role_arn
  environment_variables = {
    EVENT_BUS_NAME = module.notification_events.bus_name
  }
}

module "notification_iam" {
  source = "../../modules/iam"

  role_name = "platform-notification-execution-role"
}

module "notification_api" {
  source = "../../modules/api_gateway"

  api_name             = "platform-notification-api"
  lambda_invoke_arn    = module.notification_lambda.invoke_arn
  lambda_function_name = module.notification_lambda.function_name
  route_key            = "POST /notify"
  stage_name           = "sandbox"
}

module "notification_events" {
  source = "../../modules/events"

  bus_name                = "platform-notification-bus"
  queue_name               = "platform-notification-queue"
  event_source             = "platform.notification"
  event_detail_type        = "NotificationRequested"
  publisher_role_name      = module.notification_iam.role_name
  consumer_role_name       = module.notification_consumer_iam.role_name
  consumer_lambda_arn      = module.notification_processor_lambda.function_arn
  ses_sender_identity_arn  = "arn:aws:ses:eu-west-2:058264480534:identity/${var.sender_email}"
}

module "notification_consumer_iam" {
  source = "../../modules/iam"

  role_name = "platform-notification-processor-execution-role"
}

module "notification_processor_lambda" {
  source = "../../modules/lambda"

  function_name      = "notification-processor"
  filename           = "../../../lambda/notification-processor/notification-processor.zip"
  execution_role_arn = module.notification_consumer_iam.role_arn

  environment_variables = {
    SENDER_EMAIL    = var.sender_email
    RECIPIENT_EMAIL = var.recipient_email
  }
}