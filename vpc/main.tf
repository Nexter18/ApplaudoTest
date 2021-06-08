provider "aws" {
  region = "us-east-2"
}

# Declare the data source
data "aws_availability_zones" "available" {}

# VPC Creation
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_range_vpc
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    name = "app_test_vpc"
  }
}

# Creating Internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "app_test_igw"
  }
}

# Creating Route Table

  #Public Route Table
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "app_test_public_rt"
  }
}

# Private Route Table

resource "aws_default_route_table" "private_route" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  tags = {
    Name = "app_test_private_rt"
  }
}

# Creating Subnet

  #Public Subnet
resource "aws_subnet" "public_subnet" {
  count                   = 3
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    name = "app_test_public_subnet-${count.index + 1}"
  }
}
  
  #Private Subnet 
resource "aws_subnet" "private_subnet" {
  count                   = 3
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    name = "app_test_private_subnet-${count.index + 1}"
  }
}

# Subnet Route Table Asociation

  #Public RT Association
resource "aws_route_table_association" "public_subnet_assoc" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet.*.id[count.index]
  route_table_id = aws_route_table.public_route.id
  depends_on     = [aws_route_table.public_route, aws_subnet.public_subnet]
}

  #Private RT Association
resource "aws_route_table_association" "private_subnet_assoc" {
  count          = length(aws_subnet.private_subnet)
  subnet_id      = aws_subnet.private_subnet.*.id[count.index]
  route_table_id = aws_default_route_table.private_route.id
  depends_on     = [aws_default_route_table.private_route, aws_subnet.private_subnet]
}

# Security Group

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app_test_secgroup"
  }
}