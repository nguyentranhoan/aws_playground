resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_copy_file.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.copy_file_every_5_min.arn
}
