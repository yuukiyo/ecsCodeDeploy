resource "aws_ecs_cluster" "ecs-codedeploy" {
  name               = "${var.app-name}-cluster"
  capacity_providers = []
  tags = {
    "Name" = "${var.app-name}-cluster"
  }

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}
