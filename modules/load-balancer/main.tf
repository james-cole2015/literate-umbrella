## application load balancer
resource "aws_lb" "lu-alb" {
  name               = "${var.repo-name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group
  subnets            = var.subnet_id

  #enable_delete_protection = true

  tags = {
    environment = "dev"
    repo-name   = "${var.repo-name}"
    platform    = "terraform"
  }
}

## load balancer target group
resource "aws_lb_target_group" "lu-target-group" {
  name     = "${var.repo-name}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc
}

## load balancer listener 