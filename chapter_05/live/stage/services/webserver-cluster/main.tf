provider "aws" {
  region = "eu-central-1"
}

module "webserver_cluster" {
  # source                 = "github.com/flamarion/terraform-up-and-running//chapter_04/modules/services/webserver-cluster?ref=chapter_05"
  # ami = "ami-04e80dcb9504b6979"
  server_text            = "New server text 2"
  source                 = "../../../../modules/services/webserver-cluster"
  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "flamarion-hashicorp"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"
  instance_type          = "t2.micro"
  min_size               = 2
  max_size               = 2
  enable_autoscaling     = false
  enable_new_user_data   = false
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = module.webserver_cluster.alb_security_group_id

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
