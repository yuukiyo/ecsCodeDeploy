resource "aws_internet_gateway" "ecs-codedeploy" {
  vpc_id = aws_vpc.ecs-codedeploy.id

  tags = {
    Name = "${var.app-name}-igw"
  }
}
