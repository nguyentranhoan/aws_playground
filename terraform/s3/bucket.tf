
resource "aws_s3_bucket" "hoan-create_bucket_terraform" {
  bucket = var.hoan-terraform-source
  acl    = var.acl_value
}
#
resource "aws_s3_bucket" "hoan-athena-output" {
  bucket = var.hoan-terraform-destination
  acl    = var.acl_value
}

resource "aws_s3_bucket_object" "hoan-upload-file-terraform" {
  bucket = var.hoan-terraform-source
  key    = var.key_file
  source = var.path_to_file
}
#
#
#resource "aws_s3_object_copy" "hoan-copy-file-terraform" {
#  bucket = var.bucket_destination
#  key    = var.key_file
#  source = "${var.bucket_name}/${var.key_file}"
#
#  grant {
#    uri         = "http://acs.amazonaws.com/groups/global/AllUsers"
#    type        = "Group"
#    permissions = ["WRITE_ACP"] #FULL_CONTROL
#  }
#}
