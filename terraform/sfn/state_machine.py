from botocore import exceptions
import boto3


def create_state_machine(state_machine_name: str):
    """Creating state machine using boto3-stepfunctions"""
    print("Start creating...")
    client = boto3.client("stepfunctions")
    try:
        response = client.create_state_machine(
            name=state_machine_name,
            definition="""{
  "Comment": "A description of my state machine",
  "StartAt": "Athena StartQueryExecution",
  "States": {
    "Athena GetQueryExecution": {
      "Catch": [
        {
          "ErrorEquals": [
            "States.TaskFailed"
          ],
          "Next": "SNS Publish"
        }
      ],
      "Next": "Pass",
      "Parameters": {
        "QueryExecutionId.$": "$.QueryExecution.QueryExecutionId"
      },
      "Resource": "arn:aws:states:::athena:getQueryExecution",
      "Retry": [
        {
          "BackoffRate": 1,
          "ErrorEquals": [
            "States.TaskFailed"
          ],
          "IntervalSeconds": 1,
          "MaxAttempts": 2
        }
      ],
      "Type": "Task"
    },
    "Athena StartQueryExecution": {
      "Catch": [
        {
          "ErrorEquals": [
            "States.TaskFailed"
          ],
          "Next": "SNS Publish"
        }
      ],
      "Next": "Athena GetQueryExecution",
      "Parameters": {
        "QueryExecutionContext": {
          "Catalog": "AwsDataCatalog",
          "Database": "euro2020"
        },
        "QueryString": "SELECT SUM(scorehome) AS TOTAL_HOME_SCORES, SUM(scoreaway) AS TOTAL_AWAY_SCORE FROM match_information",
        "ResultConfiguration": {
          "OutputLocation": "s3://hoan-terraform-destination/"
        },
        "WorkGroup": "primary"
      },
      "Resource": "arn:aws:states:::athena:startQueryExecution.sync",
      "Retry": [
        {
          "BackoffRate": 1,
          "ErrorEquals": [
            "States.TaskFailed"
          ],
          "IntervalSeconds": 1,
          "MaxAttempts": 2
        }
      ],
      "Type": "Task"
    },
    "Fail": {
      "Type": "Fail"
    },
    "Pass": {
      "End": true,
      "Type": "Pass"
    },
    "SNS Publish": {
      "Next": "Fail",
      "Parameters": {
        "Message.$": "$",
        "TopicArn": "arn:aws:sns:ap-southeast-1:639039451250:hoan-sns"
      },
      "Resource": "arn:aws:states:::sns:publish",
      "Type": "Task"
    }
  }
}""",
            roleArn='arn:aws:iam::639039451250:role/hoan-sfn-role',
            type='STANDARD',
        )
        print("Created successfully")
        print(response["stateMachineArn"])
        return response["stateMachineArn"]
    except Exception:
        print("AN error occurred!")


def start_execution(state_machine_name: str):
    """Start state machine using boto3-stepfunctions"""
    print("Start creating...")
    client = boto3.client("stepfunctions")
    try:
        client.start_execution(
            stateMachineArn=create_state_machine('hoan-sfn-state-machine-python'),
        )
    except Exception:
        print("AN error occurred!")


# create_state_machine('hoan-sfn-state-machine-python')
start_execution('hoan-sfn-state-machine-python')
