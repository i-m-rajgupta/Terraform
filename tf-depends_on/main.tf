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

resource "aws_security_group" "main" {
    name = "my-sg"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "main" {
  ami = "ami-0332d564d76dbd8d6"
  instance_type = "t3.micro"
  vpc_security_group_ids = [ aws_security_group.main.id ]
  depends_on = [ aws_security_group.main ]

  lifecycle {
    # create_before_destroy = true
    # prevent_destroy = true
    replace_triggered_by = [ aws_security_group.main,aws_security_group.main.ingress ]
  }
}

