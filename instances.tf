resource "aws_instance" "covenant_c2" {
    ami                     = "ami-0a6335995610caf00" #kali
    instance_type           = var.instance_type
    key_name                = aws_key_pair.generated_key.key_name
    subnet_id               = aws_subnet.subnet_1.id
    vpc_security_group_ids  = [
        aws_security_group.port_22_all.id,
        aws_default_security_group.default.id,
        aws_security_group.port_7443.id
    ]

    tags = {
        Name = "Covenant C2"
    }

    connection {
        user            = "kali"
        type            = "ssh"
        timeout         = "2m"
        host            = self.public_ip
        private_key     = tls_private_key.c2_key.private_key_pem
    }

    provisioner "remote-exec" {
        inline = [
            "export PATH=$PATH:/usr/bin",
            "sudo apt-get update",
            "sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::=\"--force-confdef\" -o Dpkg::Options::=\"--force-confold\" dist-upgrade",
            "sudo apt-get autoremove -y",
            "sudo apt-get install -y git tmux curl tar zip gnome-terminal",
            "sudo curl -sSL https://raw.githubusercontent.com/welikechips/chips/master/tools/install-chips-defaults.sh | sudo bash",
            "sudo curl -sSL https://raw.githubusercontent.com/welikechips/chips/master/tools/install-covenant-server.sh | sudo bash"
        ]
    }
}

resource "aws_instance" "redirector_http_1" {
    ami                     = var.ami_id
    instance_type           = var.instance_type
    key_name                = aws_key_pair.generated_key.key_name
    subnet_id               = aws_subnet.subnet_1.id
    vpc_security_group_ids  = [
        aws_security_group.port_22_all.id,
        aws_default_security_group.default.id,
        aws_security_group.http_redirector.id
    ]

    tags = {
        Name = "HTTP Redirector #1"
    }

    connection {
        user            = "ubuntu"
        type            = "ssh"
        timeout         = "2m"
        host            = self.public_ip
        private_key     = tls_private_key.c2_key.private_key_pem
    }

    provisioner "remote-exec" {
        inline = [
            "export PATH=$PATH:/usr/bin",
            "sudo apt update",
            "sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::=\"--force-confdef\" -o Dpkg::Options::=\"--force-confold\" dist-upgrade",
            "sudo apt-get autoremove -y",
            "sudo apt-get install -y git tmux curl tar zip gnome-terminal",
            "sudo curl -sSL https://raw.githubusercontent.com/welikechips/chips/master/tools/install-chips-defaults.sh | sudo bash",
            "sudo curl -sSL https://raw.githubusercontent.com/welikechips/chips/master/tools/install-redirector-server.sh | sudo bash",
        ]
    }
    provisioner "local-exec" {
        command = "echo \"${tls_private_key.c2_key.private_key_pem}\" > covenant_id_rsa"
    }
    provisioner "local-exec" {
        command = "sudo chmod 600 covenant_id_rsa"
    }
}

resource "null_resource" "http_redirector_provisioning" {
    count = "1"

    connection {
        user            = "ubuntu"
        type            = "ssh"
        timeout         = "2m"
        host            = aws_instance.redirector_http_1.public_ip
        private_key     = tls_private_key.c2_key.private_key_pem
    }

    provisioner "remote-exec" {
        inline = [
                "sudo rm /etc/apache2/sites-enabled/000-default-le-ssl.conf",
                "echo 'sleeping......'",
                "sleep 60",
                "sudo certbot certonly -d \"www.${var.server_name},${var.server_name}\" --apache -n --agree-tos -m \"${var.contact_email}\"",
                "sudo curl -sSL https://raw.githubusercontent.com/welikechips/chips/master/tools/replace_000_default.sh | sudo bash -s -- ${aws_instance.redirector_http_1.public_ip} ${var.server_name}",
                "sudo curl -sSL https://raw.githubusercontent.com/welikechips/chips/master/tools/replace_default_le_ssl.sh | sudo bash -s -- ${aws_instance.covenant_c2.private_ip} ${var.server_name} ${var.spoof_server_address}",
                "sudo a2enmod ssl rewrite proxy proxy_http",
                "sudo a2ensite default-ssl.conf",
                "sudo a2enmod proxy_connect",
                "sudo service apache2 stop",
                "sudo service apache2 start",
                "sudo openssl pkcs12 -export -out /home/ubuntu/certificate.pfx -inkey /etc/letsencrypt/live/www.${var.server_name}/privkey.pem -in /etc/letsencrypt/live/www.${var.server_name}/cert.pem -certfile /etc/letsencrypt/live/www.${var.server_name}/chain.pem -password pass:${var.certificate_export_password}",
                "sudo chown ubuntu:ubuntu /home/ubuntu/certificate.pfx",
                "sudo chmod 600 /home/ubuntu/certificate.pfx"
        ]
    }
    provisioner "local-exec" {
        command = "ssh-keyscan -H ${aws_instance.redirector_http_1.public_ip} >> ~/.ssh/known_hosts"
    }   
    provisioner "local-exec" {
        command = "scp -i covenant_id_rsa ubuntu@${aws_instance.redirector_http_1.public_ip}:/home/ubuntu/certificate.pfx ."
    }   
}
