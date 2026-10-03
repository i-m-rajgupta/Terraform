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
  owner = "ABC"
  name = "MyServer"
}

resource "aws_instance" "myserver" {
  ami = "ami-004f790b835b26145"
  instance_type = var.aws_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size = var.root_block_config.v_size
    volume_type = var.root_block_config.v_type
  }

  tags = merge(var.additional_tags, {
    Name = local.name
  })
}
