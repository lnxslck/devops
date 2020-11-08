# Using the AWS NAT Gateway service instead of a nat instance, it's more expensive but easier

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway

resource "aws_nat_gateway" "nat" {
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(var.subnet_ids, count.index)
  count         = var.subnet_count
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip

resource "aws_eip" "nat" {
  vpc   = true
  count = var.subnet_count
}
