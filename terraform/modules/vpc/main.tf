resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment}-vpc"
  }
}
resource "aws_subnet" "public" {
  count = length(var.availability_zones)

  vpc_id                  = aws_vpc.this.id
  availability_zone       = var.availability_zones[count.index]
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-public-${count.index + 1}"
  }
}
resource "aws_subnet" "private" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.this.id
  availability_zone = var.availability_zones[count.index]

  cidr_block = cidrsubnet(
    var.vpc_cidr,
    8,
    count.index + 10
  )

  tags = {
    Name = "${var.environment}-private-${count.index + 1}"
  }
}