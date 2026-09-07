output "private_subnet" {
  value = module.test-vpc-module.private_subnets
}

output "public_subnet" {
  value = module.test-vpc-module.public_subnets
}

output "vpc" {
  value = module.test-vpc-module.vpc_id
}