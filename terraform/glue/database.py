from botocore import exceptions
import boto3


def create_database(database_name: str):
    """Creating database using boto3-glue"""
    print(f"Creating database {database_name}...")
    client = boto3.client("glue")
    try:
        client.create_database(
            DatabaseInput={
                'Name': database_name,
                'Description': f'{database_name} statistic',
            }
        )
        print(f"Database {database_name} created successfully!")
    except client.exceptions:
        print("An error occurred!")


def create_table(database_name: str, table_name: str):
    """Creating table using boto3-glue"""
    print(f"Creating table {table_name} for database {database_name}...")
    client = boto3.client("glue")
    try:
        client.create_table(
        DatabaseName=database_name,
        TableInput={
            'Name': table_name,
            'Description': f'{table_name} statistic',
            'StorageDescriptor': {
                'Columns': [
                    {
                        "Name": "hometeamname",
                        "Type": "string",
                        # 'Comment': '',
                        # 'Parameters': {}

                    },
                    {
                        "Name": "awayteamname",
                        "Type": "string",
                        # 'Comment': '',
                        # 'Parameters': {}
                    },
                ],
                'Location': "s3://hoan-terraform-source/",
                'InputFormat': "org.apache.hadoop.mapred.TextInputFormat",
                'OutputFormat': "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat",
                'SerdeInfo': {
                    'SerializationLibrary': "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe",
                    'Parameters': {
                        "serialization.format": ",",
                        "field.delim": ","
                    }
                },
            },
        },
    )
        print(f"Table {table_name} created successfully!")
    except exceptions:
        print("An error occurred!")


create_table("worldcup2022", "match_information")
