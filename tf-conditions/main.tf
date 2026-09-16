terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.58.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "main" {
  name = "my-sg"

  ingress  {
    to_port = 80
    from_port = 80
    protocol = "tcp"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  availability_zone = "us-east-1a"
  cidr_block = "10.0.0.0/24"
}



resource "aws_instance" "server" {
  ami = "ami-0332d564d76dbd8d6"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.private.id
  associate_public_ip_address = false
  lifecycle {
    precondition  {
    condition = aws_security_group.main.id != ""
    error_message   = "Security group Id must not be blank"
  }

  postcondition {
    condition =  self.public_ip != ""
    error_message = "Public Ip is not present"
  }
  }
  
}