import boto3
import botocore


def create_database(database: str):
    client = boto3.client("athena")
    try:
        client.start_query_execution(
            QueryString=f"CREATE DATABASE {database}",
            ResultConfiguration={
                "OutputLocation": "s3://hoan-terraform-destination/output",
            },
            # WorkGroup=string
        )
    except Exception:
        print("An error occurred!")


def create_table(database: str, table_name: str):
    client = boto3.client("athena")
    # try:
    client.start_query_execution(
    QueryString = f"""CREATE TABLE IF NOT EXISTS match_information (
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
  windspeed int
);""",
        QueryExecutionContext={
            "Database": "euro2020",
            "Catalog": "AwsDataCatalog"
        },
        ResultConfiguration={
            "OutputLocation": "s3://hoan-terraform-destination/output",
        },
        WorkGroup="primary"
    )
    # except:
    #     print("an error occurred!")


# create_database("euro2020")
create_table("a","")
