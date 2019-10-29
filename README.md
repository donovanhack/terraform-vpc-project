## Terraform VPC Project

Terraform module for creating the following:

1. VPC
2. 4 X Subnets (Public, Private, 2 X Data)
3. Elastic Load Balancer, exposed to internet on 80 and 443
4. Route53 private hosted zone
5. EC2 Instance with Nginx and attached to ELB (in private subnet)
6. RDS MySQL DB instance in data subnet

Configurable variables are listed below

### Usage

- CLI usage with default key and TF variables in a vars. file:
    - `terraform.tfvars` vars file
        ```
        mysql_username      = "rds_dba"
        mysql_password      = "Sup3rsecurePassw0rd"
        mysql_db_name       = "coolcompany"
        mysql_instance_size = "db.t2.micro"
        mysql_storage_size  = "20"
        ec2_instance_size   = "t2.micro"
        ec2_storage_size    = "10"
        ```
    - Run on cli:

          $ terraform init
          $ terraform apply

- Consuming as a module:
```
    module "terraform-vpc-project" {
        source              = "git@github.com:donovanhack/terraform-vpc-project.git"
        mysql_username      = "rds_dba"
        mysql_password      = "Sup3rsecurePassw0rd"
        mysql_db_name       = "coolcompany"
        mysql_instance_size = "db.t2.micro"
        mysql_storage_size  = "20"
        ec2_instance_size   = "t2.micro"
        ec2_storage_size    = "10"
    }
```
