resource "aws_ecs_service" "ecs-codedeploy" {
  cluster                            = aws_ecs_cluster.ecs-codedeploy.id
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = 2
  enable_ecs_managed_tags            = false
  health_check_grace_period_seconds  = 0
  launch_type                        = "FARGATE"
  name                               = "${var.app-name}-service"
  platform_version                   = "1.3.0"
  scheduling_strategy                = "REPLICA"
  tags                               = {}
  task_definition                    = var.app-name

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  load_balancer {
    container_name   = var.app-name
    container_port   = 80
    target_group_arn = aws_lb_target_group.ecs-codedeploy-x.arn
  }

  network_configuration {
    assign_public_ip = true
    security_groups = [
      aws_security_group.alb-sg.id
    ]
    subnets = [
      aws_subnet.ecs-codedeploy-private-subnet-a.id,
      aws_subnet.ecs-codedeploy-private-subnet-c.id
    ]
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      load_balancer,
    ]
  }

  depends_on = [
    aws_lb_target_group.ecs-codedeploy-x
  ]
}
