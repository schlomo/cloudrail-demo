provider "aws" {
  region = "us-east-1"
}

locals {
  cidr_block = "192.168.100.0/24"
}

resource "aws_vpc" "main" {
  cidr_block = local.cidr_block
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = local.cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_security_group" "allow-public-outbound-sg" {
  name        = "allow-public-outbound-sg"
  description = "Allow HTTPS outbound traffic"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "test" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow-public-outbound-sg.id]
  subnet_id = aws_subnet.public-subnet.id
}

resource "aws_s3_bucket" "public-bucket" {
  bucket = "public-bucket"
  acl = "public-read"
  tags = {
    Name        = "public-bucket"
  }
}