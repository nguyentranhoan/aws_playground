import sys
import pandas
import boto3


def handler(event, context):
    return 'Hello from AWS Lambda using Python' + sys.version + '!'