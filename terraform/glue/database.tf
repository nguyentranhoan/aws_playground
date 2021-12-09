resource "aws_glue_catalog_database" "euro2020" {
  name = var.database_name
}


resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
  name          = var.table_name
  database_name = var.database_name

  table_type = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL              = "TRUE"
  }

  storage_descriptor {
    location      = "s3://hoan-terraform-source/"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"

      parameters = {
        "serialization.format" = ",",
        "field.delim" = ","
      }
    }

    columns {
      name = "hometeamname"
      type = "string"
    }
    columns {
          name = "awayteamname"
          type = "string"
    }
    columns {
          name = "dateandtimecet"
          type = "date"
    }
    columns {
          name = "matchid"
          type = "int"
    }
    columns {
          name = "roundname"
          type = "string"
    }
    columns {
          name = "matchday"
          type = "int"
    }
    columns {
          name = "session"
          type = "int"
    }
    columns {
          name = "matchminute"
          type = "int"
    }
    columns {
          name = "injurytime"
          type = "int"
    }
    columns {
          name = "numberofphases"
          type = "int"
    }
    columns {
          name = "phase"
          type = "int"
    }
    columns {
          name = "scorehome"
          type = "int"
    }
    columns {
          name = "scoreaway"
          type = "int"
    }
    columns {
          name = "matchstatus"
          type = "string"
    }
    columns {
          name = "stadiumid"
          type = "int"
    }
    columns {
          name = "refereewebname"
          type = "string"
    }
    columns {
          name = "assistantrefereewebname"
          type = "string"
    }
    columns {
          name = "humidity"
          type = "int"
    }
    columns {
          name = "temperature"
          type = "int"
    }
    columns {
          name = "windspeed"
          type = "int"
    }
  }
}
