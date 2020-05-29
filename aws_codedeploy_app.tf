resource "aws_codedeploy_app" "ecs-codedeploy" {
  compute_platform = "ECS"
  name             = var.app-name
}
