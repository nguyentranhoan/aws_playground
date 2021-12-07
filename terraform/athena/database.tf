resource "aws_athena_workgroup" "athena-database" {
  name = "athena-database"

  configuration {
    result_configuration {
      output_location = "s3://${var.hoan-terraform-destination}/output/"
    }
  }
}

resource "aws_athena_database" "euro2020" {
  name   = "euro2020"
  bucket = var.hoan-terraform-destination
}


#resource "aws_athena_named_query" "foo" {
#  name      = "bar"
#  workgroup = aws_athena_workgroup.test.id
#  database  = aws_athena_database.hoge.name
#  query     = "SELECT * FROM ${aws_athena_database.hoge.name} limit 10;"
#}
