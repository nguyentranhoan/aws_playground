variable "aws_athena_workgroup_name" {
    default = "athena-database"
}

variable "database_name" {
    default = "euro2020"
}

variable "table_name" {
    default = "match_information"
}

variable "hoan-terraform-source" {
    default = "hoan-terraform-source"
}

variable "hoan-terraform-destination" {
    default = "hoan-terraform-destination"
}
