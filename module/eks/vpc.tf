resource "aws_vpc" "eks-vpc" {
  cidr_block = var.block1
  tags = {
    Name = var.vpcname
  }
}

resource "aws_subnet" "pubsub01" {
  vpc_id = aws_vpc.eks-vpc.id
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  cidr_block = var.block2
  tags = {
    Name = var.pubsub01
  }
}

resource "aws_subnet" "pubsub02" {
  vpc_id = aws_vpc.eks-vpc.id
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
  cidr_block = var.block3
  tags = {
    Name = var.pubsub02
  }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.eks-vpc.id
}

resource "aws_route_table" "pubrt" {
  vpc_id = aws_vpc.eks-vpc.id
  route {
    cidr_block = var.block4
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "pubrtassociate1" {
  route_table_id = aws_route_table.pubrt.id
  subnet_id = aws_subnet.pubsub01.id
}

resource "aws_route_table_association" "pubrtassociate2" {
  route_table_id = aws_route_table.pubrt.id
  subnet_id = aws_subnet.pubsub02.id
}