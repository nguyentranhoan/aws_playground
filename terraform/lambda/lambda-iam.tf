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

resource "aws_iam_role" "hoan_iam_for_lambda" {
  name = "hoan-lambda-role"
  managed_policy_arns = [aws_iam_policy.s3_iam_policy.arn]
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
