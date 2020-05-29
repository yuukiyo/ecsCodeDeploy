resource "aws_subnet" "ecs-codedeploy-public-subnet-a" {
  vpc_id                  = aws_vpc.ecs-codedeploy.id
  cidr_block              = "10.192.10.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.app-name}-public-subnet-a"
  }
}

resource "aws_subnet" "ecs-codedeploy-public-subnet-c" {
  vpc_id                  = aws_vpc.ecs-codedeploy.id
  cidr_block              = "10.192.11.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.app-name}-public-subnet-c"
  }
}

resource "aws_subnet" "ecs-codedeploy-private-subnet-a" {
  vpc_id                  = aws_vpc.ecs-codedeploy.id
  cidr_block              = "10.192.20.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.app-name}-private-subnet-a"
  }
}

resource "aws_subnet" "ecs-codedeploy-private-subnet-c" {
  vpc_id                  = aws_vpc.ecs-codedeploy.id
  cidr_block              = "10.192.21.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.app-name}-private-subnet-c"
  }
}
