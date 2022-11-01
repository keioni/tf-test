# VPC resource
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  assign_generated_ipv6_cidr_block = true
  enable_dns_support               = true
  enable_dns_hostnames             = true

  tags = {
    Name = "vpc-${var.app}-${var.env}"
  }
}

# Subnet resource
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "main" {
  count = 3

  vpc_id            = aws_vpc.main.id
  az                = var.aws_azs[count.index]
  availability_zone = "${var.aws_region}${az}"
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  ipv6_cidr_block   = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, parseint("0${az}", 16))

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "net-${var.app}-${var.env}-${az}"
  }
}

# IGW resource
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-${var.app}-${var.env}"
  }
}

# Route Table resource
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.main.id
  }

  tags = {
    Name = "rtb-${var.app}-${var.env}"
  }
}
