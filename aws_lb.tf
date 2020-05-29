resource "aws_lb" "ecs-codedeploy" {
  name                       = "${var.app-name}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb-sg.id]
  enable_deletion_protection = false
  idle_timeout               = 30
  subnets = [
    aws_subnet.ecs-codedeploy-public-subnet-a.id,
    aws_subnet.ecs-codedeploy-public-subnet-c.id
  ]
  tags = {
    "Name" = "${var.app-name}-alb"
  }
}
