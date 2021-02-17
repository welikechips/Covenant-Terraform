provider "aws" {
    region     = var.region
}

resource "tls_private_key" "c2_key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
    key_name   = "covenant-c2-private-key"
    public_key = tls_private_key.c2_key.public_key_openssh
}

resource "aws_eip" "ip" {
    instance = aws_instance.covenant_c2.id
    vpc      = true
}

resource "aws_eip" "mail_ip" {
    instance = aws_instance.phishing_mailing_server.id
    vpc      = true
}