terraform {
  required_version = ">= 0.12"
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "kaumudilimited"
    workspaces { prefix = "vpc-" }
    token = "Nuje3UaUWZejfw.atlasv1.b8WyyU71sBblde95tWS6aQZIgEhHyKGTRBXr03XByBmoLjiqvJ8ZFfzi8DrizQgf2GA"
  }
}

provider "aws" {
  region = "ap-south-1"
}


module "http_sg" {
  source = "github.com/kapilty/terraform-modules/modules/sg"

  name        = "computed-http-sg"
  description = "Security group with HTTP port open for everyone, and HTTPS open just for the default security group"
  vpc_id      = vpc-0bcfc7dacc703ade8

  ingress_cidr_blocks = ["0.0.0.0/0"]

  ingress_with_source_security_group_id = [
    {
      rule                     = "https-443-tcp"
      source_security_group_id = data.aws_security_group.default.id
    },
  ]
}
