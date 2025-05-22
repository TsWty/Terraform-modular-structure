provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source            = "./modules/ec2"
  ami               = "ami-0953476d60561c955"
  instance_type     = "t2.micro"
  subnet_id         = module.vpc.subnet_id
  security_group_id = module.sg.security_group_id
  key_name = "blog"
}
