locals {
    lambda_zip_location= "output/lambda_function.zip"
}

data "archive_file" "lambda_function" {
  type        = "zip"
  source_file = "lambda/lambda_function.py"
  output_path = local.lambda_zip_location
}

resource "aws_lambda_function" "lambda_copy_file" {
  filename      = local.lambda_zip_location
  function_name = "lambda_function"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
}
