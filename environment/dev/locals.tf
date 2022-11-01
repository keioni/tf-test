locals {
  aws_region = "ap-northeast-1"
  aws_azs    = ["a", "c", "d"]

  vpc_cidr_block = "10.64.0.0/16"

  env = "dev"
  app = "onimaru-tf"
}
