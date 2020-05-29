resource "null_resource" "redeploy" {
  triggers = {
    task_definition_arn = aws_ecs_task_definition.ecs-codedeploy.arn
  }

  provisioner "local-exec" {
    command = "./redeploy.sh ${aws_codedeploy_app.ecs-codedeploy.name} ${var.app-name}-dg ${var.app-name} 80 ${aws_ecs_task_definition.ecs-codedeploy.arn}"
  }
}
