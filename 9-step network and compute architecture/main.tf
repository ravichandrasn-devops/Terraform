
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "x_vpc" {
  cidr_block = "10.201.0.0/16"
}

resource "aws_internet_gateway" "x_ig" {
  vpc_id = aws_vpc.x_vpc.id

}

resource "aws_route_table" "x_rt" {
  vpc_id = aws_vpc.x_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.x_ig.id
  }
}

resource "aws_subnet" "x_sn" {
  vpc_id                  = aws_vpc.x_vpc.id
  cidr_block              = "10.201.33.0/24"
  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "x_rt" {
  route_table_id = aws_route_table.x_rt.id
  subnet_id      = aws_subnet.x_sn.id
}

resource "aws_security_group" "x_sg" {
  name   = "security1"
  vpc_id = aws_vpc.x_vpc.id
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "0.0.0.0/0"
  }

}

resource "aws_network_interface" "x_ni" {
  subnet_id       = aws_subnet.x_sn.id
  security_groups = security1.id
}

resource "aws_eip" "x_eip" {
  domain            = "vpc"
  network_interface = aws_network_interface.x_ni.id

}

resource "aws_instance" "x_frontend" {
  primary_network_interface {
    network_interface_id  = aws_network_interface.x_ni.id
    delete_on_termination = false
  }
  ami           = "ami-1234"
  instance_type = "t3.micro"
}


