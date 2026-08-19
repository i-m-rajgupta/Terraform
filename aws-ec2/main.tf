
terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "6.58.0"
      }
    }
}

provider "aws" {
    region = var.region
}

resource "aws_instance" "myserver" {
    ami = "ami-0b6d9d3d33ba97d99"
    instance_type = "t3.small"

    tags = {
        Name = "MyWebServer"
    }
}