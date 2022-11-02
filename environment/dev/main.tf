terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = local.aws_region
  profile = "sandbox-terraform"

  default_tags {
    tags = {
      Env = local.env
      App = local.app
    }
  }
}

module "main" {
  source = "../../modules/vpc"

  vpc_cidr_block = local.vpc_cidr_block

  aws_region = local.aws_region
  aws_azs    = local.aws_azs

  env = local.env
  app = local.app
}
