resource "aws_security_group" "webserver-pvt-sg" {
    vpc_id = aws_vpc.coolcompany_vpc.id

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = merge(local.tags, {Name = "webserver-pvt-sg"})
}


resource "aws_security_group" "elb-public-sg" {
    vpc_id = aws_vpc.coolcompany_vpc.id

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(local.tags, {Name = "elb-public-sg"})
}

resource "aws_security_group" "mysql-sg" {
    vpc_id = aws_vpc.coolcompany_vpc.id

    egress {
        from_port   = 0
        protocol    = -1
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 3306
        protocol    = "tcp"
        to_port     = 3306
        cidr_blocks = [aws_vpc.coolcompany_vpc.cidr_block]
    }

    tags = merge(local.tags, {Name = "mysql-pvt-sg"})
}
