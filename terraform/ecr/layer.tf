resource "aws_ecr_repository" "my_repository" {
  name = "my-docker-repo"
}

data "aws_ecr_image" "my_image" {
  repository_name = aws_ecr_repository.my_repository.name
  image_tag       = "latest"
  # Other optional attributes if needed, e.g., image digest or tag
}

resource "null_resource" "docker_login" {
  provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${aws_ecr_repository.my_repository.repository_url}"
  }
}

resource "null_resource" "build_and_push" {
  depends_on = [null_resource.docker_login]

  provisioner "local-exec" {
    command = "docker build -t ${aws_ecr_repository.my_repository.repository_url}:latest ."
  }

  provisioner "local-exec" {
    command = "docker push ${aws_ecr_repository.my_repository.repository_url}:latest"
  }
}


resource "aws_iam_role" "my_lambda_role" {
  name = "my-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_execution_role" {
  name       = "lambda_execution_role"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  roles      = [aws_iam_role.my_lambda_role.name]
}

resource "aws_lambda_function" "my_lambda_function" {
  function_name    = "my-lambda-function"
  role             = aws_iam_role.my_lambda_role.arn
  handler          = "handler.handler"  # Adjust to your Lambda function handler
  runtime          = "provided.al2"
  timeout          = 10
  memory_size      = 256
  package_type     = "Image"
  image_uri        = "736148933604.dkr.ecr.us-east-1.amazonaws.com/my-docker-repo:latest"
  # Other optional attributes for Lambda function configuration
}
