provider "aws" {
  region = "us-east-1"
}

data "terraform_remote_state" "application" {
  backend = "remote"
  config = {
    organization = "knjoroge-org"
    workspaces = {
      name = "aws-1-application"
    }
  }
}

resource "aws_instance" "test" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = data.terraform_remote_state.application.outputs.subnet_id
}
