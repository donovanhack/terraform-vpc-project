#Nat gateway for private subnet
resource "aws_eip" "coolcompany-natgw-eip" {
  vpc  = true
  tags = merge(local.tags, {Name = "coolcompany-natgw-eip"})
}

resource "aws_nat_gateway" "coolcompany-natgw" {
  allocation_id = aws_eip.coolcompany-natgw-eip.id
  subnet_id     = aws_subnet.coolcompany_public_subnet.id
  depends_on    = [aws_internet_gateway.coolcompany-igw]
  tags          = merge(local.tags, {Name = "coolcompany-natgw"})
}

resource "aws_route_table" "coolcompany-private-rtb" {
  vpc_id = aws_vpc.coolcompany_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.coolcompany-natgw.id
  }

  tags = merge(local.tags, {Name = "coolcompany-private-rtb"})
}

resource "aws_route_table_association" "coolcompany-rta-private-subnet" {
  route_table_id = aws_route_table.coolcompany-private-rtb.id
  subnet_id      = aws_subnet.coolcompany_private_subnet.id
}

#Internet gateway for public subnet
resource "aws_internet_gateway" "coolcompany-igw" {
    vpc_id = aws_vpc.coolcompany_vpc.id
    tags   = merge(local.tags, {Name = "coolcompany-igw"})
}

resource "aws_route_table" "coolcompany-public-rtb" {
    vpc_id = aws_vpc.coolcompany_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.coolcompany-igw.id
    }
    tags   = merge(local.tags, {Name = "coolcompany-public-rtb"})
}

resource "aws_route_table_association" "coolcompany-rta-public-subnet"{
    subnet_id = aws_subnet.coolcompany_public_subnet.id
    route_table_id = aws_route_table.coolcompany-public-rtb.id
}

resource "aws_route_table_association" "coolcompany-rta-public-subnet-elb"{
    subnet_id = aws_subnet.coolcompany_public_subnet.id
    route_table_id = aws_route_table.coolcompany-public-rtb.id
}
