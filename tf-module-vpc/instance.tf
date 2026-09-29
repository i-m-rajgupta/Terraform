module "ec2-instance" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "6.4.0"
  name = "single-instance"

  ami = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.micro"
  subnet_id = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  tags = {
    Environment = "dev"
    Name = "module-project"
  }
}

