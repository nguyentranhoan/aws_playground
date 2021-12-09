resource "aws_iam_role" "hoan_sfn_role" {
  name = "hoan-sfn-role"
  managed_policy_arns = [aws_iam_policy.sfn_iam_policy.arn, aws_iam_policy.get_query.arn,
                         aws_iam_policy.sns_publish_scope_access.arn, aws_iam_policy.x_ray_access.arn]
  assume_role_policy = jsonencode({
    Statement: [
      {
        Action: "sts:AssumeRole",
        Principal: {
          Service: "states.amazonaws.com"
        },
        Effect: "Allow",
        Sid: ""
      }
    ]
  })
}

resource "aws_iam_policy" "sfn_iam_policy" {
  name        = "sfn_iam_policy"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "athena:startQueryExecution",
                "athena:getDataCatalog"
            ],
            "Resource": [
                "arn:aws:athena:ap-southeast-1:639039451250:workgroup/primary",
                "arn:aws:athena:ap-southeast-1:639039451250:datacatalog/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketLocation",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:ListBucketMultipartUploads",
                "s3:ListMultipartUploadParts",
                "s3:AbortMultipartUpload",
                "s3:CreateBucket",
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "glue:CreateDatabase",
                "glue:GetDatabase",
                "glue:GetDatabases",
                "glue:UpdateDatabase",
                "glue:DeleteDatabase",
                "glue:CreateTable",
                "glue:UpdateTable",
                "glue:GetTable",
                "glue:GetTables",
                "glue:DeleteTable",
                "glue:BatchDeleteTable",
                "glue:BatchCreatePartition",
                "glue:CreatePartition",
                "glue:UpdatePartition",
                "glue:GetPartition",
                "glue:GetPartitions",
                "glue:BatchGetPartition",
                "glue:DeletePartition",
                "glue:BatchDeletePartition"
            ],
            "Resource": [
                "arn:aws:glue:ap-southeast-1:639039451250:catalog",
                "arn:aws:glue:ap-southeast-1:639039451250:database/*",
                "arn:aws:glue:ap-southeast-1:639039451250:table/*",
                "arn:aws:glue:ap-southeast-1:639039451250:userDefinedFunction/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "lakeformation:GetDataAccess"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
})
}


resource "aws_iam_policy" "get_query" {
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "athena:getQueryExecution"
            ],
            "Resource": [
                "arn:aws:athena:ap-southeast-1:639039451250:workgroup/*"
            ]
        }
    ]
})
}


resource "aws_iam_policy" "x_ray_access" {
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "xray:PutTraceSegments",
                "xray:PutTelemetryRecords",
                "xray:GetSamplingRules",
                "xray:GetSamplingTargets"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
})
}

resource "aws_iam_policy" "sns_publish_scope_access" {
    name = "sns-publish-scope-access"
    policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sns:Publish"
            ],
            "Resource": [
                "arn:aws:sns:ap-southeast-1:639039451250:hoan-sns"
            ]
        }
    ]
})
}
