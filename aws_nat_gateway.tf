resource "aws_eip" "nat-a" {
  vpc = true
}

resource "aws_eip" "nat-c" {
  vpc = true
}

resource "aws_nat_gateway" "nat-a" {
  allocation_id = aws_eip.nat-a.id
  subnet_id     = aws_subnet.ecs-codedeploy-public-subnet-a.id

  tags = {
    Name = "ecs-codedeploy-natgw-a"
  }
}

resource "aws_nat_gateway" "nat-c" {
  allocation_id = aws_eip.nat-c.id
  subnet_id     = aws_subnet.ecs-codedeploy-public-subnet-c.id

  tags = {
    Name = "ecs-codedeploy-natgw-c"
  }
}
