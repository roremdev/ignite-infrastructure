resource "aws_internet_gateway" "global" {
  vpc_id = aws_vpc.global.id

  tags = {
    Name = local.network.internet_gateway.name
  }
}