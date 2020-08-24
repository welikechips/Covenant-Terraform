//security.tf
resource "aws_security_group" "port_22_all" {
    name = "port_22_all"
    vpc_id = aws_vpc.cloudc2-vpc.id
    ingress {
        cidr_blocks = var.access_cidrs
        from_port = 22
        to_port = 22
        protocol = "tcp"
    }
    // Terraform removes the default rule
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "Port 22 all"
    }
}

resource "aws_default_security_group" "default" {
    vpc_id = aws_vpc.cloudc2-vpc.id

    ingress {
        protocol  = -1
        self      = true
        from_port = 0
        to_port   = 0
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "http_redirector" {
    name = "443 80 open only to allow access"
    vpc_id = aws_vpc.cloudc2-vpc.id
    ingress {
        cidr_blocks = var.only_allow_access_to_cidrs
        from_port = 443
        to_port = 443
        protocol = "tcp"
    }
    ingress {
        cidr_blocks = var.only_allow_access_to_cidrs
        from_port = 80
        to_port = 80
        protocol = "tcp"
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "443 80 open only to allow access"
    }
}

resource "aws_security_group" "port_7443" {
    name = "Covenant Port 7443"
    vpc_id = aws_vpc.cloudc2-vpc.id
    ingress {
        cidr_blocks = var.access_cidrs
        from_port = 7443
        to_port = 7443
        protocol = "tcp"
    }
    // Terraform removes the default rule
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "Covenant Port 7443"
    }
}