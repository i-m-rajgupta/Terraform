terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.58.0"
    }
    random = {
        source = "hashicorp/random"
        version = "3.9.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "aws-bucket" {
  bucket = "my-aws-demo-tf-${random_id.rand_id.hex}"
}

output "name" {
  value = random_id.rand_id.hex
}