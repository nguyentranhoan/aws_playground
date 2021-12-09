resource "aws_iam_policy" "s3_iam_policy" {
  name        = "s3_policy"
  policy      = jsonencode({
    Version: var.aws_iam_policy_version,
    Statement: [
        {
            Effect: "Allow",
            Action: [
                "s3:*",
                "s3-object-lambda:*"
            ],
            Resource: "*"
        }
    ]
})
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "lambda_role"
  assume_role_policy = jsonencode({
    Statement: [
      {
        Action: "sts:AssumeRole",
        Principal: {
          Service: "lambda.amazonaws.com"
        },
        Effect: "Allow",
        Sid: ""
      }
    ]
  })
}


resource "aws_iam_role_policy" "hoan-test" {
  name = "test_policy"
  role = aws_iam_role.iam_for_lambda.id
  policy = jsonencode({
    Version = var.aws_iam_role_policy_version
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
