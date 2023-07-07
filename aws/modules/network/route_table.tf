resource "aws_route_table" "public" {
  vpc_id = aws_vpc.global.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.global.id
  }

  tags = {
    Name        = local.network.route_table.public.name
    environment = local.environment
  }
}

resource "aws_route_table_association" "zone_a" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.zone_a.id
}

resource "aws_route_table_association" "zone_b" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.zone_b.id
}