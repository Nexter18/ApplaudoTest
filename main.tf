provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source         = "./vpc"
  cidr_range_vpc = "10.0.0.0/16"
  public_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_cidrs  = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "ec2" {
  source         = "./ec2"
  my_public_key  = "/.ssh/pb-JHELIRRNTGPEZT6AO5JPEKKHDHOGI6TE.pub"
  ami            = "ami-0b9064170e32bde34"
  instance_type  = "t2.micro"
  security_group = module.vpc.security_group
  subnets        = module.vpc.public_subnets
}

module "lb" {
  source = "./lb"
  vpc_id = module.vpc.vpc_id


  security_group = module.vpc.security_group

  subnet1 = module.vpc.subnet1

  subnet2 = module.vpc.subnet2

  subnet3 = module.vpc.subnet3
}