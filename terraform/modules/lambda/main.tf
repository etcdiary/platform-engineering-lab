
resource "aws_lambda_function" "this" {
  function_name = var.function_name
  role          = var.execution_role_arn

  runtime = var.runtime
  handler = var.handler

  filename         = var.filename
  source_code_hash = filebase64sha256(var.filename)

  timeout     = var.timeout
  memory_size = var.memory_size
}