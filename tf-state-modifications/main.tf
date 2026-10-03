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

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my_vpc"
  }
}

resource "aws_subnet" "main" {
  count = 2
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.${count.index}.0/24"
  tags = {
    Name = "aws-subnet-${count.index}"
  }
}


resource "aws_instance" "myserver" {
 ami = "ami-0b6d9d3d33ba97d99"
 instance_type = "t3.micro"

 tags = {
   Name = "mysampleserver"
 }
}