resource "aws_iam_role" "ecs-codedeploy-execution-role" {
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs-codedeploy-execution-role-AmazonECSTaskExecutionRolePolicy" {
  role       = aws_iam_role.ecs-codedeploy-execution-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs-codedeploy-cd-service-role" {
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
           "razorbillfrontend-gamma.amazon.com",
           "codedeploy.amazonaws.com"
        ]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs-codedeploy-cd-service-role-AWSCodeDeployRoleForECS" {
  role       = aws_iam_role.ecs-codedeploy-cd-service-role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
}

resource "aws_iam_role_policy" "ecs-codedeploy-cd-service-role-passRoleForCodeDeploy" {
  name = "passRoleForCodeDeploy"
  role = aws_iam_role.ecs-codedeploy-cd-service-role.id

  policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Action": "iam:PassRole",
    "Resource": "${aws_iam_role.ecs-codedeploy-execution-role.arn}",
    "Effect": "Allow"
  }
}
  EOF
}
