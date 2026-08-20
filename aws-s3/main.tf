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

resource "aws_s3_bucket" "aws-bucket" {
  bucket = "aws-bucket-demo-09-tf"
}

resource "aws_s3_object" "bucket-data" {
  bucket = aws_s3_bucket.aws-bucket.bucket
  source = "./myfile.txt"
  key = "mydata.txt"
}

