terraform {
  # Require any 0.12.x version of Terraform
  required_version = "~> 0.12"
}

provider "aws" {
  region = "eu-central-1"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

module "hello_world_app" {
  source                 = "github.com/flamarion/terraform-up-and-running//chapter_06/modules/services/hello-world-app?ref=v0.0.6"
  server_text = "New server text"
  environment = "stage"
  # db_remote_state_bucket = "flamarion-hashicorp"
  # db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"
  db_remote_state_bucket = "foo"
  db_remote_state_key    = "bar"

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 2
  enable_autoscaling = false
}
