# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true

  tags = {
    Name        = var.environment
    Environment = var.environment
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway

resource "aws_internet_gateway" "vpc" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Environment = var.environment
  }
}
