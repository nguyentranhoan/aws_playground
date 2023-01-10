
provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region = var.region
}

module "s3" {
    source = "./s3/"
}

# module "athena" {
#     depends_on = [module.s3]
#     source = "./athena/"
# }

# module "sns" {
#     source = "./sns/"
# }

# module "sfn" {
#     source = "./sfn/"
# }

# module "glue" {
#     source = "./glue/"
#     depends_on = [module.athena]
# }

# module "lambda" {
#     source = "./lambda/"
# }

