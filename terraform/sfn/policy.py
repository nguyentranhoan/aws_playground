import boto3
import json


def create_policy(policy_name: str, policy_document: str, description=''):
    """Create policy"""
    """Response Syntax
        {
            'Policy': {
                'PolicyName': 'string',
                'PolicyId': 'string',
                'Arn': 'string',
                'Path': 'string',
                'DefaultVersionId': 'string',
                'AttachmentCount': 123,
                'PermissionsBoundaryUsageCount': 123,
                'IsAttachable': True|False,
                'Description': 'string',
                'CreateDate': datetime(2015, 1, 1),
                'UpdateDate': datetime(2015, 1, 1),
                'Tags': [
                    {
                        'Key': 'string',
                        'Value': 'string'
                    },
                ]
            }
        }"""
    client = boto3.client('iam')
    print("start")
    try:
        response = client.create_policy(
            PolicyName=policy_name,
            PolicyDocument=policy_document,
            Description=description,
        )
        print(response)
        print("done")
        return response['Arn']
    except Exception:
        print("AN error occurred!")


get_query = """{
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
}"""

create_policy("hoan-get-query-python", get_query)


def create_role(role_name: str, assume_role_policy_document: str, permissions_boundary: str, description=''):
    """create bla bla"""
    client = boto3.client('iam')
    print("start")
    try:
        response = client.create_role(
            RoleName=role_name,
            AssumeRolePolicyDocument=assume_role_policy_document,
            Description=description,
            PermissionsBoundary=permissions_boundary,
        )
        print(response)
        print("done")
        return response
    except Exception:
        print("AN error occurred!")


assume_role_policy_document = """{
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
  }"""

arn = create_policy("hoan-get-query-python", get_query)

create_role("hoan-role-python", assume_role_policy_document, arn)
