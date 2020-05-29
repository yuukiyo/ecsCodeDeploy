resource "aws_cloudwatch_log_group" "ecs-codedeploy" {
  name = var.app-name
}
