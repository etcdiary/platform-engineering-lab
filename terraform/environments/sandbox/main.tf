provider "aws" {
  region = "eu-west-2"
  allowed_account_ids = ["058264480534"]
}

module "notification_lambda" {
  source = "../../modules/lambda"

  function_name = "platform-notification"
  filename      = "../../../lambda/notification/notification.zip"
}