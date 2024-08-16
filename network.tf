data "aws_availability_zones" "available" {}

resource "aws_vpc" "app" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "vpc-${var.app_name}"
  }
}

resource "aws_subnet" "public" {
  count             = var.az_count
  vpc_id            = aws_vpc.app.id
  cidr_block        = cidrsubnet(aws_vpc.app.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  # map_public_ip_on_launch = true
  tags = {
    Name = "snet-public-${var.app_name}-${count.index}"
  }
}

resource "aws_internet_gateway" "app" {
  vpc_id = aws_vpc.app.id

  tags = {
    Name = "igw-${var.app_name}"
  }
}

resource "aws_route_table" "app" {
  vpc_id = aws_vpc.app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app.id
  }

  tags = {
    Name = "rtb-${var.app_name}"
  }
}

resource "aws_route_table_association" "app" {
  count          = var.az_count
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.app.id
}
