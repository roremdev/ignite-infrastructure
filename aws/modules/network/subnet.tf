resource "aws_subnet" "zone_a" {
  vpc_id                  = aws_vpc.global.id
  cidr_block              = local.network.subnet.zone_a.cidr_block
  map_public_ip_on_launch = true
  availability_zone       = local.network.subnet.zone_a.availability_zone

  tags = {
    Name        = local.network.subnet.zone_a.name
    environment = local.environment
    scope       = local.network.subnet.zone_a.scope
  }
}

resource "aws_subnet" "zone_b" {
  vpc_id                  = aws_vpc.global.id
  cidr_block              = local.network.subnet.zone_b.cidr_block
  map_public_ip_on_launch = true
  availability_zone       = local.network.subnet.zone_b.availability_zone

  tags = {
    Name        = local.network.subnet.zone_b.name
    environment = local.environment
    scope       = local.network.subnet.zone_b.scope
  }
}