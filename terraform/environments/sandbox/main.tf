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