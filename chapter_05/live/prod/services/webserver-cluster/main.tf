provider "aws" {
  region = "eu-central-1"
}

module "webserver_cluster" {
  source                 = "../../../../modules/services/webserver-cluster"
  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "flamarion-hashicorp"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"
  instance_type          = "m4.large"
  min_size               = 2
  max_size               = 10
  enable_autoscaling     = true
  enable_new_user_data   = false
  custom_tags = {
    Owner      = "team-foo"
    DeployedBy = "terraform"
  }
}
