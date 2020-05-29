resource "aws_lb_listener" "ecs-codedeploy-prod" {
  load_balancer_arn = aws_lb.ecs-codedeploy.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs-codedeploy-x.arn
  }

  lifecycle {
    ignore_changes = [
      default_action.0.target_group_arn
    ]
  }
  depends_on    = [aws_lb_target_group.ecs-codedeploy-x]

}

resource "aws_lb_listener" "ecs-codedeploy-test" {
  load_balancer_arn = aws_lb.ecs-codedeploy.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs-codedeploy-x.arn
  }

  lifecycle {
    ignore_changes = [
      default_action.0.target_group_arn
    ]
  }
  depends_on    = [aws_lb_target_group.ecs-codedeploy-y]
}
