locals {
    lambda_zip_location= var.zip_lambda_function_location
}

data "archive_file" "lambda_function" {
  type        = "zip"
  source_file = var.lambda_function_location
  output_path = local.lambda_zip_location
}

resource "aws_lambda_function" "lambda_copy_file" {
  filename      = local.lambda_zip_location
  function_name = "lambda_function"
  role          = aws_iam_role.hoan_iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
}
