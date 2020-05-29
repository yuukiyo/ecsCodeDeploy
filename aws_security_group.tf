resource "aws_security_group" "alb-sg" {
  name        = "${var.app-name}-alb-sg"
  description = "Access to the public facing load balancer"
  vpc_id      = aws_vpc.ecs-codedeploy.id
}

resource "aws_security_group_rule" "alb-sg" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  ipv6_cidr_blocks  = []
  prefix_list_ids   = []
  protocol          = "tcp"
  security_group_id = aws_security_group.alb-sg.id
  self              = false
  to_port           = 80
  type              = "ingress"
}

resource "aws_security_group_rule" "alb-sg-1" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 8080
  ipv6_cidr_blocks  = []
  prefix_list_ids   = []
  protocol          = "tcp"
  security_group_id = aws_security_group.alb-sg.id
  self              = false
  to_port           = 8080
  type              = "ingress"
}

resource "aws_security_group_rule" "alb-sg-2" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  ipv6_cidr_blocks  = []
  prefix_list_ids   = []
  protocol          = "-1"
  security_group_id = aws_security_group.alb-sg.id
  self              = false
  to_port           = 0
  type              = "egress"
}
