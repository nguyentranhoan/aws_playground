resource "aws_sns_topic_subscription" "hoan_email_noti" {
  topic_arn = aws_sns_topic.hoan_sns.arn #"arn:aws:sns:ap-southeast-1:${var.account_id}:hoan-sns"
  protocol  = var.protocol
  endpoint  = var.endpoint
  depends_on = [aws_sns_topic.hoan_sns]
}
