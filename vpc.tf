resource "aws_vpc" "coolcompany_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = merge(local.tags, {Name = "coolcompany_vpc"})
}

resource "aws_subnet" "coolcompany_public_subnet" {
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-1a"
  vpc_id                  = aws_vpc.coolcompany_vpc.id
  map_public_ip_on_launch = true
  tags                    = merge(local.tags, {Name = "coolcompany_public_subnet"})
}

resource "aws_subnet" "coolcompany_private_subnet" {
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-1a"
  vpc_id                  = aws_vpc.coolcompany_vpc.id
  map_public_ip_on_launch = false
  tags                    = merge(local.tags, {Name = "coolcompany_private_subnet"})
}

#Two data subnets are required in two AZ's due to MySQL aurora requirements
resource "aws_subnet" "coolcompany_data_subnet-1" {
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "eu-west-1a"
  vpc_id                  = aws_vpc.coolcompany_vpc.id
  map_public_ip_on_launch = false
  tags                    = merge(local.tags, {Name = "coolcompany_data_subnet-1"})
}
resource "aws_subnet" "coolcompany_data_subnet-2" {
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "eu-west-1c"
  vpc_id                  = aws_vpc.coolcompany_vpc.id
  map_public_ip_on_launch = false
  tags                    = merge(local.tags, {Name = "coolcompany_data_subnet-2"})
}
