resource "aws_nat_gateway" "nat" {
  allocation_id = var.eip_allocation_id
  subnet_id     = var.subnet_id
  tags          = merge(var.tags, { "Name" = "NAT Gateway" })
}
