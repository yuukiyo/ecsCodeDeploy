resource "aws_codedeploy_deployment_group" "ecs-codedeploy" {
  app_name               = aws_codedeploy_app.ecs-codedeploy.name
  deployment_group_name  = "${var.app-name}-dg"
  deployment_config_name = "CodeDeployDefault.ECSLinear10PercentEvery1Minutes"
  service_role_arn       = aws_iam_role.ecs-codedeploy-cd-service-role.arn
  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout    = "CONTINUE_DEPLOYMENT"
      wait_time_in_minutes = 0
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }
  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = "${var.app-name}-cluster"
    service_name = "${var.app-name}-service"
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [
          aws_lb_listener.ecs-codedeploy-prod.arn
        ]
      }

      target_group {
        name = aws_lb_target_group.ecs-codedeploy-x.name
      }
      target_group {
        name = aws_lb_target_group.ecs-codedeploy-y.name
      }

      test_traffic_route {
        listener_arns = [
          aws_lb_listener.ecs-codedeploy-test.arn
        ]
      }
    }
  }
  depends_on = [
    aws_ecs_cluster.ecs-codedeploy,
    aws_ecs_service.ecs-codedeploy
  ]
}
