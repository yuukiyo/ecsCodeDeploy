resource "aws_vpc" "ecs-codedeploy" {
  cidr_block           = "10.192.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = var.app-name
  }
}
