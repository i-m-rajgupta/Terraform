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

data "aws_vpc" "name" {
    tags = {
    Name = "my_vpc"
    }
}

output "vpc" {
  value = data.aws_vpc.name.id
}

data "aws_security_group" "name" {
  tags = {
    Name = "myserver-sg"
  }
}

output "aws_sg" {
  value = data.aws_security_group.name.id
}

data "aws_subnet" "name" {
    tags = {
      Name = "private subnet"
    }
}

output "subnet" {
  value = data.aws_subnet.name.id
}

resource "aws_instance" "myserver" {
  ami = "ami-004f790b835b26145"
  subnet_id = data.aws_subnet.name.id
  vpc_security_group_ids = [data.aws_security_group.name.id]
  instance_type = "t3.micro"

  tags = {
    Name = "my-server"
  }
}