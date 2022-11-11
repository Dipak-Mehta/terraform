# create elastic IP

resource "aws_eip" "eipfornat" {
  vpc        = true
  depends_on = [aws_internet_gateway.myigw]
  tags = {
    Name = "NAT-GW-ELASTICIP"
  }
}

# create NAT gateway

resource "aws_nat_gateway" "mynatgateway" {
  allocation_id = aws_eip.eipfornat.id
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "mynatgateway"
  }
}

# create route table for private

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mynatgateway.id
  }


  tags = {
    Name = "private-rt"
  }
}

# create route table association

resource "aws_route_table_association" "private-association" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-rt.id
}