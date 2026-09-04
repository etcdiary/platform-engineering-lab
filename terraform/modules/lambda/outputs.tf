output "function_name" {
  value = aws_lambda_function.this.function_name
}

output "function_arn" {
  value = aws_lambda_function.this.arn
}

output "execution_role_arn" {
  value = var.execution_role_arn
}
output "invoke_arn" {
  value = aws_lambda_function.this.invoke_arn
}