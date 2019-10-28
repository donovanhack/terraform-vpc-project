# I would use below method if this was a public domain, but unfortunately ACM does not allow validation against private hosted zones, so will use a self signed certificate

//resource "aws_acm_certificate" "coolcompany_acm_cert" {
//
//  domain_name       = aws_route53_zone.coolcompany_private_zone.name
//  validation_method = "DNS"
//
//  lifecycle {
//    create_before_destroy = true
//  }
//
//  tags   = merge(local.tags, {Name = "coolcompany_acm_cert"})
//}

//resource "aws_route53_record" "cert_validation" {
//  name    = aws_acm_certificate.coolcompany_acm_cert.domain_validation_options.0.resource_record_name
//  type    = aws_acm_certificate.coolcompany_acm_cert.domain_validation_options.0.resource_record_type
//  zone_id = aws_route53_zone.coolcompany_private_zone.id
//  records = [
//    aws_acm_certificate.coolcompany_acm_cert.domain_validation_options[0].resource_record_value]
//  ttl     = 60
//}
//
//resource "aws_acm_certificate_validation" "coolcompany_cert" {
//  certificate_arn         = aws_acm_certificate.coolcompany_acm_cert.arn
//  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
//}

resource "tls_private_key" "coolcompany-private-key" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "coolcompany-self-signed-cert" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.coolcompany-private-key.private_key_pem

  subject {
    common_name  = "*.coolcompany.com"
    organization = "Cool Company"
  }

  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth"
  ]
}

resource "aws_acm_certificate" "coolcompany-acm-cert" {
  private_key      = tls_private_key.coolcompany-private-key.private_key_pem
  certificate_body = tls_self_signed_cert.coolcompany-self-signed-cert.cert_pem
}
