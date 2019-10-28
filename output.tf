output "nginx_instance_ip" {
  value = aws_instance.coolcompany-nginx.private_ip
}
output "elb_endpoint" {
  value = aws_elb.coolcompany-elb.dns_name
}
output "elb_cname" {
  value = aws_route53_record.coolcompany-cname.fqdn
}
output "mysql_endpoint" {
  value = aws_db_instance.coolcompany-mysql-instance.endpoint
}
output "mysql_username" {
  value = aws_db_instance.coolcompany-mysql-instance.username
}
output "mysql_password" {
  value = aws_db_instance.coolcompany-mysql-instance.password
}