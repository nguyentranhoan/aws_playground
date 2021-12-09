resource "aws_sfn_state_machine" "hoan-sfn_state_machine" {
  name     = "hoan-sfn_state_machine"
  depends_on = [aws_iam_policy.sfn_iam_policy]
  role_arn = aws_iam_role.hoan_sfn_role.arn  #"arn:aws:iam::639039451250:role/service-role/StepFunctions-hoan-test-state_machine-role-08e8009d"

  definition = jsonencode(
{
  "Comment": "A description of my state machine",
  "StartAt": "Athena StartQueryExecution",
  "States": {
    "Athena StartQueryExecution": {
      "Type": "Task",
      "Resource": "arn:aws:states:::athena:startQueryExecution.sync",
      "Parameters": {
        "QueryExecutionContext": {
          "Catalog": var.catalog,
          "Database": var.database
        },
        "QueryString": var.query_compare_scores,
        "ResultConfiguration": {
          "OutputLocation": var.output_location
        },
        "WorkGroup": "primary"
      },
      "Next": "Athena GetQueryExecution",
      "Retry": [
        {
          "ErrorEquals": [
            "States.TaskFailed"
          ],
          "BackoffRate": 1,
          "IntervalSeconds": 1,
          "MaxAttempts": 2
        }
      ],
      "Catch": [
        {
          "ErrorEquals": [
            "States.TaskFailed"
          ],
          "Next": "SNS Publish"
        }
      ]
    },
    "Athena GetQueryExecution": {
      "Type": "Task",
      "Resource": "arn:aws:states:::athena:getQueryExecution",
      "Parameters": {
        "QueryExecutionId.$": "$.QueryExecution.QueryExecutionId"
      },
      "Next": "Pass",
      "Retry": [
        {
          "ErrorEquals": [
            "States.TaskFailed"
          ],
          "BackoffRate": 1,
          "IntervalSeconds": 1,
          "MaxAttempts": 2
        }
      ],
      "Catch": [
        {
          "ErrorEquals": [
            "States.TaskFailed"
          ],
          "Next": "SNS Publish"
        }
      ]
    },
    "SNS Publish": {
      "Type": "Task",
      "Resource": "arn:aws:states:::sns:publish",
      "Parameters": {
        "Message.$": "$",
        "TopicArn": "arn:aws:sns:ap-southeast-1:639039451250:hoan-sns"
      },
      "Next": "Fail"
    },
    "Fail": {
      "Type": "Fail"
    },
    "Pass": {
      "Type": "Pass",
      "End": true
    }
  }
}
)
}
