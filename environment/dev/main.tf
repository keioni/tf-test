provider "aws" {
  region = local.aws_region

  default_tags {
    Env = local.env
    App = local.app
  }
}

module "main" {
  vpc_cidr_block = local.vpc_cidr_block

  aws_region = local.aws_region
  aws_azs    = local.aws_azs

  env = local.env
  app = local.app
}
