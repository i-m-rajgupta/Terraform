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

locals {
  project = "my-project"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id = aws_vpc.my_vpc.id
  count = 2
  cidr_block = "10.0.${count.index}.0/24"
  availability_zone = element(var.availability-zones,count.index)

  tags = {
    Name = "${local.project}-subnet-${count.index}"
  }
}

# resource "aws_instance" "main" {
#   count = length(var.ec2_config)
#   ami = var.ec2_config[count.index].ami
#   instance_type = var.ec2_config[count.index].instance_type
  
#   subnet_id = element(aws_subnet.main[*].id,count.index % length(aws_subnet.main))

#   tags = {
#     Name = "${local.project}-instance-${count.index}"
#   }
# }

resource "aws_instance" "main" {
  for_each = var.ec2_map

  ami = each.value.ami
  instance_type = each.value.instance_type
  
  subnet_id = element(aws_subnet.main[*].id,index(keys(var.ec2_map),each.key) % length(aws_subnet.main))

  tags = {
    Name = "${local.project}-instance-${each.key}"
  }
}

output "output" {
  value = aws_subnet.main[0].id
}