provider "aws" {
  region = "us-west-2"
}

# Create a new load balancer
resource "aws_lb" "app_tf_elb" {
  name               = "app-test-lb"
  load_balancer_type = "application"
  security_groups =  [var.security_group]

  subnets = [
    var.subnet1,
    var.subnet2,
    var.subnet3
  ]

  enable_deletion_protection = true

  tags = {
    Name = "app-test-lb"
  }
}

resource "aws_lb_target_group" "test" {
  name     = "app-test-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}