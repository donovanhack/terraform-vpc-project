resource "aws_elb" "coolcompany-elb" {

  name               = "coolcompany-elb"

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  security_groups = [aws_security_group.elb-public-sg.id]
  subnets         = [aws_subnet.coolcompany_public_subnet.id]

  listener {
    instance_port      = 443
    instance_protocol  = "https"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = aws_acm_certificate.coolcompany-acm-cert.arn
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = [aws_instance.coolcompany-nginx.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  internal                    = false

  tags = merge(local.tags, {Name = "coolcompany-webserver-elb"})

}

resource "aws_route53_record" "coolcompany-cname" {
  name    = "mywebserver"
  type    = "CNAME"
  zone_id = aws_route53_zone.coolcompany_private_zone.zone_id
  ttl     = "60"
}
