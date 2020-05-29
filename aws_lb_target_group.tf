resource "aws_lb_target_group" "ecs-codedeploy-x" {
  name        = "${var.app-name}-x-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.ecs-codedeploy.id

  health_check {
    interval            = 6
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = 200
  }
  depends_on = [aws_lb.ecs-codedeploy]
}

resource "aws_lb_target_group" "ecs-codedeploy-y" {
  name        = "${var.app-name}-y-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.ecs-codedeploy.id

  health_check {
    interval            = 6
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = 200
  }
  depends_on = [aws_lb.ecs-codedeploy]
}
