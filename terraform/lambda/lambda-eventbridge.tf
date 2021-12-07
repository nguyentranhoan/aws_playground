resource "aws_cloudwatch_event_rule" "copy_file_every_5_min" {
  name        = "copy_file_every_5_min"
  description = "copy file between buckets for every 5 mins"

  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "copy_file_between_buckets" {
  rule      = aws_cloudwatch_event_rule.copy_file_every_5_min.name
  target_id = "BucketToBucket"
  arn       = aws_lambda_function.lambda_copy_file.arn
}
