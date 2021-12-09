variable "s3_bucket" {
  default = "my_bucket"
}
variable "lambda_function" {
  default = "test-lambda"
}

variable "role_name" {
  default = ""
}

variable "schedule_expression" {
  default = "rate(5 minutes)"
}

variable "lambda_function_location" {
  default = "lambda/lambda_function.py"
}

variable "zip_lambda_function_location" {
  default = "output/lambda_function.zip"
}

variable "aws_iam_role_policy_version" {
  default = "2012-10-17"
}

variable "aws_iam_policy_version" {
  default = "2012-10-17"
}
