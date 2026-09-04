provider "aws" {
  region = "eu-west-2"
  allowed_account_ids = ["058264480534"]
}

module "notification_lambda" {
  source = "../../modules/lambda"

  function_name = "platform-notification"
  filename      = "../../../lambda/notification/notification.zip"
  execution_role_arn = module.notification_iam.role_arn  
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
  stage_name            = "sandbox"
}