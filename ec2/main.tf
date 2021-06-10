provider "aws" {
  region = "us-east-2"
}

data "aws_availability_zones" "available" {}

resource "aws_key_pair" "apptest_key" {
  key_name   = "app-test-key"
  public_key = file(var.my_public_key)
}

resource "aws_instance" "app_test_instance" {
  count                  = 2
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.apptest_key.id
  vpc_security_group_ids = [var.security_group]
  subnet_id              = element(var.subnets, count.index )
  user_data = <<-EOF
                    #!/bin/bash
                    sudo yum update -y
                    sudo yum install nginx -y 
                    sudo service nginx start
                EOF

  tags = {
    Name = "Applaudo_test_instance-${count.index + 1}"
  }
}