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
  ami           = "ami-0e36db3a3a535e401"
  instance_type = "t2.micro"
  subnet_id     = data.terraform_remote_state.application.outputs.subnet_id
}

output "test_instance_id" {
  value = aws_instance.test.id
}
