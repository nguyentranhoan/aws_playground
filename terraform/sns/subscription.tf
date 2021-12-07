resource "aws_sns_topic_subscription" "hoan_email_noti" {
  topic_arn = "arn:aws:sns:ap-southeast-1:639039451250:hoan-sns"
  protocol  = var.protocol
  endpoint  = var.endpoint
}
