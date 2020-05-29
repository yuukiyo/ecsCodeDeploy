resource "aws_route_table" "ecs-codedeploy-public-route-table" {
  vpc_id = aws_vpc.ecs-codedeploy.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecs-codedeploy.id
  }

  tags = {
    Name = "${var.app-name}-public-route-table"
  }
}

resource "aws_route_table" "ecs-codedeploy-private-route-table-a" {
  vpc_id = aws_vpc.ecs-codedeploy.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-a.id
  }

  tags = {
    Name = "${var.app-name}-private-route-table-a"
  }
}

resource "aws_route_table" "ecs-codedeploy-private-route-table-c" {
  vpc_id = aws_vpc.ecs-codedeploy.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-c.id
  }

  tags = {
    Name = "${var.app-name}-private-route-table-c"
  }
}

resource "aws_route_table_association" "ecs-codedeploy-public-subnet-a" {
  subnet_id      = aws_subnet.ecs-codedeploy-public-subnet-a.id
  route_table_id = aws_route_table.ecs-codedeploy-public-route-table.id
}

resource "aws_route_table_association" "ecs-codedeploy-public-subnet-c" {
  subnet_id      = aws_subnet.ecs-codedeploy-public-subnet-c.id
  route_table_id = aws_route_table.ecs-codedeploy-public-route-table.id
}

resource "aws_route_table_association" "ecs-codedeploy-private-subnet-a" {
  subnet_id      = aws_subnet.ecs-codedeploy-private-subnet-a.id
  route_table_id = aws_route_table.ecs-codedeploy-private-route-table-a.id
}

resource "aws_route_table_association" "ecs-codedeploy-private-subnet-c" {
  subnet_id      = aws_subnet.ecs-codedeploy-private-subnet-c.id
  route_table_id = aws_route_table.ecs-codedeploy-private-route-table-c.id
}
