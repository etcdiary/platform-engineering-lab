resource "aws_cloudwatch_event_bus" "this" {
  name = var.bus_name
}

resource "aws_sqs_queue" "this" {
  name                       = var.queue_name
  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400
}

resource "aws_cloudwatch_event_rule" "this" {
  name           = "${var.bus_name}-rule"
  event_bus_name = aws_cloudwatch_event_bus.this.name

  event_pattern = jsonencode({
    source      = [var.event_source]
    detail-type = [var.event_detail_type]
  })
}

resource "aws_cloudwatch_event_target" "sqs" {
  rule           = aws_cloudwatch_event_rule.this.name
  event_bus_name = aws_cloudwatch_event_bus.this.name
  arn            = aws_sqs_queue.this.arn
}

resource "aws_sqs_queue_policy" "allow_eventbridge" {
  queue_url = aws_sqs_queue.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "events.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.this.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_cloudwatch_event_rule.this.arn
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "publisher_putevents" {
  name = "${var.bus_name}-putevents"
  role = var.publisher_role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "events:PutEvents"
        Resource = aws_cloudwatch_event_bus.this.arn
      }
    ]
  })
}
resource "aws_iam_role_policy" "consumer_sqs" {
  name = "${var.queue_name}-consume"
  role = var.consumer_role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = aws_sqs_queue.this.arn
      }
    ]
  })
}

resource "aws_iam_role_policy" "consumer_ses" {
  name = "${var.queue_name}-send-email"
  role = var.consumer_role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "ses:SendEmail"
        Resource = var.ses_sender_identity_arn
      }
    ]
  })
}

resource "aws_lambda_event_source_mapping" "sqs_to_processor" {
  event_source_arn = aws_sqs_queue.this.arn
  function_name    = var.consumer_lambda_arn
  batch_size       = 5
}