########################################################################
### vpc
########################################################################
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

########################################################################
### igw
########################################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

########################################################################
### subnets
########################################################################
resource "aws_subnet" "public_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public-2"
  }
}

########################################################################
### rt table
########################################################################
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

########################################################################
### rt table mapping
########################################################################
resource "aws_route_table_association" "m1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "m2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.rt.id
}
