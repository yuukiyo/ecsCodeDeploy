resource "aws_ecs_task_definition" "ecs-codedeploy" {
  container_definitions    = <<TASK_DEFINITION
  [
                {
                  "command"               : [],
                  "cpu"                   : 256,
                  "dnsSearchDomains"      : [],
                  "dnsServers"            : [],
                  "dockerSecurityOptions" : [],
                  "entryPoint"            : [],
                  "environment"           : [],
                  "essential"             : true,
                  "image"                 : "yuukiyo/ecs-sample-app:v2",
                  "links"                 : [],
                  "logConfiguration"      : {
                    "logDriver" : "awslogs",
                    "options"   : {
                      "awslogs-group"         : "${var.app-name}",
                      "awslogs-region"        : "ap-northeast-1",
                      "awslogs-stream-prefix" : "logs"
                    }
                  },
                  "memory"                : 512,
                  "mountPoints"           : [],
                  "name"                  : "${var.app-name}",
                  "portMappings"          : [
                    {
                      "containerPort" : 80,
                      "hostPort"      : 80,
                      "protocol"      : "tcp"
                    }
                  ],
                  "systemControls"        : [],
                  "volumesFrom"           : []
                }
  ]
  TASK_DEFINITION
  cpu                      = "256"
  execution_role_arn       = aws_iam_role.ecs-codedeploy-execution-role.arn
  family                   = var.app-name
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  tags                     = {}
}
