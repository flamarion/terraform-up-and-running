provider "aws" {
  region = "eu-central-1"
}

terraform {
  required_version = ">= 0.12, < 0.13"
  backend "s3" {
    # Replace this with your bucket name!
    bucket = "flamarion-hashicorp"
    key    = "prod/data-stores/mysql/terraform.tfstate"
    region = "eu-central-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "flamarion-hashicorp-locks"
    encrypt        = true
  }
}


resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = var.db_name
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
}
