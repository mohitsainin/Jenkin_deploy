resource "aws_route" "default_rt" {
route_table_id = data.aws_route_table.default_RT.id
destination_cidr_block = var.cidr_range
vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  
}

resource "aws_route" "RT-1" {
  route_table_id = var.public_route_table_id
  destination_cidr_block = var.default_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id

}
resource "aws_route" "RT-2" {
  route_table_id = var.private_route_table_id
  destination_cidr_block = var.default_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id

}

data "aws_security_group" "default_sg" {
  vpc_id = data.aws_vpc.default_vpc.id
  filter {
    name = "group-name"
    values = [ "default" ]
  }
}
