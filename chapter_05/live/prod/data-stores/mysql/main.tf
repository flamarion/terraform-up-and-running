provider "aws" {
  region = "eu-central-1"
}

terraform {
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
  name                = "example_database"
  username            = "admin"
  skip_final_snapshot = true

  # How should we set the password?
  password = var.db_password
}
