variable "query_compare_scores" {
  default = <<-EOT
    SELECT SUM(scorehome) AS TOTAL_HOME_SCORES, SUM(scoreaway) AS TOTAL_AWAY_SCORE
    FROM match_information
  EOT
}


variable "output_location" {
  default = "s3://hoan-terraform-destination/"
}

variable "database" {
  default = "euro2020"
}

variable "catalog" {
  default = "AwsDataCatalog"
}
