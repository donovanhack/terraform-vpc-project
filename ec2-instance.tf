resource "aws_instance" "coolcompany-nginx" {

  ami                         = "ami-0ce71448843cb18a1"
  instance_type               = var.ec2_instance_size
  subnet_id                   = aws_subnet.coolcompany_private_subnet.id
  user_data                   = file("files/install_nginx.sh")
  vpc_security_group_ids      = [aws_security_group.webserver-pvt-sg.id]    # the Public SSH key
  key_name                    = aws_key_pair.coolcompany-nginx-keypair.id
  tags                        = merge(local.tags, {Name = "coolcompany-nginx"})

  connection {
    user = "ec2-user"
    private_key = file("files/coolcompany.pem")
  }

  root_block_device {
    volume_size = var.ec2_storage_size
  }

}

resource "aws_key_pair" "coolcompany-nginx-keypair" {
    key_name   = "coolcompany-kp"
    public_key = file("files/coolcompany.pem.pub")
}
