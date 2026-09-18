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

data "aws_ami" "name" {
    most_recent = true
    owners = ["amazon"]
}

output "aws_ami" {
  value = data.aws_ami.name.id
}

data "aws_security_group" "name" {
  tags = {
    Name = "Mywebserver"
  }
}

output "sg" {
  value = data.aws_security_group.name.id
}

data "aws_vpc" "name" {
    tags = {
      Name = "my_vpc" 
    }
}

output "vpc" {
  value = data.aws_vpc.name.id
}

data "aws_availability_zones" "names" {
    state = "available"
}

output "az" {
  value = data.aws_availability_zones.names
}

data "aws_region" "name" {
}

output "region_name" {
  value = data.aws_region.name
}
data "aws_caller_identity" "name" {
}

output "caller_info" {
  value = data.aws_caller_identity.name
}
resource "aws_instance" "myserver" {
  ami = data.aws_ami.name.id
  instance_type = "t3.micro"

  tags = {
    Name = "Myserver"
  }
}

