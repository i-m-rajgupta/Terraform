terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.58.0"
    }
  }
  backend "s3" {
    bucket = "aws-bucket-demo-09-tf"
    key = "backend.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "myserver" {
  ami = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.micro"

  tags = {
    Name = "SampleServer"
  }
}