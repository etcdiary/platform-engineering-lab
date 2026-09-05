output "api_endpoint" {
  description = "Invoke URL for the API stage"
  value       = "${aws_apigatewayv2_api.this.api_endpoint}/${aws_apigatewayv2_stage.this.name}"
}

output "api_id" {
  value = aws_apigatewayv2_api.this.id
}

# output "invoke_arn" {
#   value = aws_lambda_function.this.invoke_arn
# }

output "api_domain_only" {
  value = replace(aws_apigatewayv2_api.this.api_endpoint, "https://", "")
}