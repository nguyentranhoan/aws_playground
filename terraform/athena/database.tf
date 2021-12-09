resource "aws_athena_workgroup" "athena-database" {
  name = var.aws_athena_workgroup_name
  configuration {
    result_configuration {
      output_location = var.output_location
    }
  }
}

#resource "aws_athena_named_query" "create_match_info_table" {
#  depends_on = [aws_glue_catalog_database.euro2020]
#  name      = var.aws_athena_named_query_name
#  workgroup = aws_athena_workgroup.athena-database.id
#  database  = aws_glue_catalog_database.euro2020.name
#  query     = var.create_match_info_table
#}


#resource "aws_glue_catalog_database" "euro2020" {
#  depends_on = [aws_athena_workgroup.athena-database]
#  name = "euro2020"
#}
#
#
#resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
#  name          = "match_information"
#  database_name = "euro2020"
#
#  table_type = "EXTERNAL_TABLE"
#
#  parameters = {
#    EXTERNAL              = "TRUE"
#  }
#
#  storage_descriptor {
#    location      = "s3://hoan-terraform-source/"
#    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
#    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
#
#    ser_de_info {
#      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
#
#      parameters = {
#        "serialization.format" = ",",
#        "field.delim" = ","
#      }
#    }
#
#    columns {
#      name = "hometeamname"
#      type = "string"
#}
#    columns {
#          name = "awayteamname"
#          type = "string"
#    }
#    columns {
#          name = "dateandtimecet"
#          type = "date"
#    }
#    columns {
#          name = "matchid"
#          type = "int"
#    }
#    columns {
#          name = "roundname"
#          type = "string"
#    }
#    columns {
#          name = "matchday"
#          type = "int"
#    }
#    columns {
#          name = "session"
#          type = "int"
#    }
#    columns {
#          name = "matchminute"
#          type = "int"
#    }
#    columns {
#          name = "injurytime"
#          type = "int"
#    }
#    columns {
#          name = "numberofphases"
#          type = "int"
#    }
#    columns {
#          name = "phase"
#          type = "int"
#    }
#    columns {
#          name = "scorehome"
#          type = "int"
#    }
#    columns {
#          name = "scoreaway"
#          type = "int"
#    }
#    columns {
#          name = "matchstatus"
#          type = "string"
#    }
#    columns {
#          name = "stadiumid"
#          type = "int"
#    }
#    columns {
#          name = "refereewebname"
#          type = "string"
#    }
#    columns {
#          name = "assistantrefereewebname"
#          type = "string"
#    }
#    columns {
#          name = "humidity"
#          type = "int"
#    }
#    columns {
#          name = "temperature"
#          type = "int"
#    }
#    columns {
#          name = "windspeed"
#          type = "int"
#    }
#  }
#}
