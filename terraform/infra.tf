#VPC
resource "aws_vpc" "project-vpc" {
  cidr_block = "10.0.0.0/16"
  tags       = { Name = "project-vpc" }
}

#public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.project-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Public Subnet"
  }
}

#route table for pablic subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.project-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

#attaching public RT to subnet
resource "aws_route_table_association" "public_subnet_asso" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}


#internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.project-vpc.id

  tags = {
    Name = "Project VPC IG"
  }
}