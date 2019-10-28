resource "aws_route53_zone" "coolcompany_private_zone" {
  name = "coolcompany.com"
  tags = merge(local.tags, {Name = "coolcompany_private_zone"})
  vpc {
    vpc_id = aws_vpc.coolcompany_vpc.id
  }
}
