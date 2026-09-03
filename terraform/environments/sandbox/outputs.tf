output "notification_lambda_function_name" {
  value = module.notification_lambda.function_name
}

output "notification_lambda_function_arn" {
  value = module.notification_lambda.function_arn
}

output "notification_lambda_execution_role_arn" {
  value = module.notification_lambda.execution_role_arn
}
