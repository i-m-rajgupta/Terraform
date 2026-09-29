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

resource "aws_s3_bucket" "main" {
    bucket = "amzn-03-demo-0q"
}