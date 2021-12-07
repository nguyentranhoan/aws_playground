import boto3
import botocore


def create_database(database: str):
    client = boto3.client('athena')
    try:
        client.start_query_execution(
            QueryString=f'CREATE DATABASE {database}',
            # ClientRequestToken='string',
            # QueryExecutionContext={
            #     'Database': 'string',
            #     # 'Catalog': 'string'
            # },
            ResultConfiguration={
                'OutputLocation': 's3://hoan-test-terraform/athena/output',
                # 'EncryptionConfiguration': {
                #     'EncryptionOption': 'SSE_S3'|'SSE_KMS'|'CSE_KMS',
                #     'KmsKey': 'string'
                # }
            },
            # WorkGroup='string'
        )
    except client.exceptions:
        print('An error occurred!')


def create_table(database: str, table_name: str):
    client = boto3.client('athena')
    try:
        pass
    except:
        pass


create_database("euro2020")
