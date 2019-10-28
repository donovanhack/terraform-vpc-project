resource "aws_db_parameter_group" "coolcompany-mysql-parameter-group" {

  name        = "coolcompany-mysql-parameter-group"
  description = "coolcompany-mysql-parameter-group"
  family      = "mysql5.7"
  tags        = merge(local.tags, {Name = "coolcompany-mysql-parameter-group"})

}

resource "aws_db_subnet_group" "coolcompany-mysql-subnet-group" {

  name        = "coolcompany-mysql-subnet-group"
  description = "coolcompany-mysql-subnet-group"
  subnet_ids  = [aws_subnet.coolcompany_data_subnet-1.id, aws_subnet.coolcompany_data_subnet-2.id]
  tags        = merge(local.tags, {Name = "coolcompany-mysql-subnet-group"})

}

resource "random_password" "password" {
  length           = 30
  special          = true
  min_lower        = 1
  min_numeric      = 1
  min_upper        = 1
  min_special      = 1
  override_special = "!#$%^&*()"
}

resource "aws_secretsmanager_secret" "coolcompany-mysql-credentials" {
  name                    = "coolcompany-mysql-creds"
  recovery_window_in_days = 0
  tags                    = merge(local.tags, {Name = "coolcompany-mysql-credentials"})
}

resource "aws_secretsmanager_secret_version" "coolcompany-mysql-credentials-version" {
  secret_id     = aws_secretsmanager_secret.coolcompany-mysql-credentials.id
  secret_string = jsonencode({
    "username" = var.mysql_username
    "password" = random_password.password
  })
}

resource "aws_db_instance" "coolcompany-mysql-instance" {
  allocated_storage          = var.mysql_storage_size
  identifier                 = "coolcompany-mysql-instance"
  skip_final_snapshot        = true
  multi_az                   = true
  auto_minor_version_upgrade = false
  storage_type               = "gp2"
  engine                     = "mysql"
  engine_version             = "5.7.22"
  instance_class             = var.mysql_instance_size
  name                       = var.mysql_db_name
  username                   = var.mysql_username
  password                   = var.mysql_password #Use jsondecode(aws_secretsmanager_secret_version.coolcompany-mysql-credentials-version.secret_string)["password"]["result"] for password generated above
  parameter_group_name       = aws_db_parameter_group.coolcompany-mysql-parameter-group.name
  db_subnet_group_name       = aws_db_subnet_group.coolcompany-mysql-subnet-group.name
  tags                       = merge(local.tags, {Name = "coolcompany-mysql-instance"})
}
