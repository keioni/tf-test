resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  assign_generated_ipv6_cidr_block = true
  enable_dns_support               = true
  enable_dns_hostnames             = true

  tags = {
    Name = "vpc-${var.app}-${var.env}"
  }
}

resource "aws_subnet" "main" {
  count = 3

  vpc_id            = aws_vpc.main.id
  availability_zone = "${var.aws_region}${var.aws_azs[count.index]}"
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  ipv6_cidr_block   = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, parseint("0${var.aws_azs[count.index]}", 16))

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "net-${var.app}-${var.env}-${var.aws_azs[count.index]}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-${var.app}-${var.env}"
  }
}

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
