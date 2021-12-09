variable "aws_athena_workgroup_name" {
    default = "athena-database"
}

variable "database_name" {
    default = "euro2020"
}

variable "hoan-terraform-source" {
    default = "hoan-terraform-source"
}

variable "hoan-terraform-destination" {
    default = "hoan-terraform-destination"
}

variable "create_match_info_table" {
  default = <<-EOT
    CREATE EXTERNAL TABLE IF NOT EXISTS 'euro2020'.'match_information' (
      'hometeamname' string,
      'awayteamname' string,
      'dateandtimecet' date,
      'matchid' int,
      'roundname' string,
      'matchday' int,
      'session' int,
      'matchminute' int,
      'injurytime' int,
      'numberofphases' int,
      'phase' int,
      'scorehome' int,
      'scoreaway' int,
      'matchstatus' string,
      'stadiumid' int,
      'refereewebname' string,
      'assistantrefereewebname' string,
      'humidity' int,
      'temperature' int,
      'windspeed' int
    )
    ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
    WITH SERDEPROPERTIES (
      'serialization.format' = ',',
      'field.delim' = ','
    ) LOCATION 's3://hoan-terraform-source/'
    TBLPROPERTIES ('has_encrypted_data'='false');
  EOT
}


variable "aws_athena_named_query_name" {
    default = "create-match-info-table"
}


variable "output_location" {
    default = "s3://hoan-terraform-destination/output/"
}
