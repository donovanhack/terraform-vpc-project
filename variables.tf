variable "mysql_username" {
  type        = "string"
  description = "username to use for mysql instance"
}

variable "mysql_password" {
  type        = "string"
  description = "password to use for mysql db"
}

variable "mysql_db_name" {
  type        = "string"
  description = "name of mysql DB"
}

variable "mysql_instance_size" {
  type        = "string"
  description = "Instance type of DB"
}

variable "mysql_storage_size" {
  type        = "string"
  description = "Storage space allocated to DB instance"
}

variable "ec2_instance_size" {
  type        = "string"
  description = "Instance type of EC2 instance"
}

variable "ec2_storage_size" {
  type        = "string"
  description = "Block storage size for EC2 volume"
}
