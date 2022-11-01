output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_ipv6_cidr_block" {
  value = aws_vpc.main.ipv6_cidr_block
}

output "subnet_id" {
  value = aws_subnet.main.*.id
}

output "subnet_az" {
  value = aws_subnet.main.*.availability_zone
}

output "subnet_cidr_block" {
  value = aws_subnet.main.*.cidr_block
}

output "subnet_ipv6_cidr_block" {
  value = aws_subnet.main.*.ipv6_cidr_block
}

