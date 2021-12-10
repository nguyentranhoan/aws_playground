import boto3
import botocore


def create_database(database: str):
    client = boto3.client("athena")
    try:
        response = client.start_query_execution(
            QueryString=f"CREATE DATABASE {database}",
            ResultConfiguration={
                "OutputLocation": "s3://hoan-terraform-destination/output",
            },
            # WorkGroup=string
        )
        print(response)
        return response
    except Exception:
        print("An error occurred!")


def create_table(database: str, table_name: str):
    client = boto3.client("athena")
    # try:
    response = client.start_query_execution(
            QueryString=f"""CREATE TABLE IF NOT EXISTS {table_name} (
                              hometeamname string,
                              awayteamname string,
                              dateandtimecet date,
                              matchid int,
                              roundname string,
                              matchday int,
                              session int,
                              matchminute int,
                              injurytime int,
                              numberofphases int,
                              phase int,
                              scorehome int,
                              scoreaway int,
                              matchstatus string,
                              stadiumid int,
                              refereewebname string,
                              assistantrefereewebname string,
                              humidity int,
                              temperature int,
                              windspeed int)
                              ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
                                WITH SERDEPROPERTIES (
                                  'serialization.format' = ',',
                                  'field.delim' = ','
                                ) LOCATION 's3://hoan-terraform-source/'
                                TBLPROPERTIES ('has_encrypted_data'='false');""",
            QueryExecutionContext={
                "Database": database,
                "Catalog": "AwsDataCatalog"
            },
            ResultConfiguration={
                "OutputLocation": "s3://hoan-terraform-destination/out/test.csv",
            },
            WorkGroup="primary"
        )
    #     print(response)
    #     return response
    # except Exception:
    #     print("an error occurred!")


# create_database("euro2020")
create_table("euro2020", "test")
