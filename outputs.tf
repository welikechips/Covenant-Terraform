output "covenant_public_ip" {
    value = aws_eip.ip.public_ip
}

output "covenant_private_ip" {
    value = aws_instance.covenant_c2.private_ip
}

output "http_phishing_application_public_ip" {
    value = aws_instance.phishing_application_server.public_ip
}

output "http_phishing_application_private_ip" {
    value = aws_instance.phishing_application_server.private_ip
}

output "http_phishing_mailing_public_ip" {
    value = aws_instance.phishing_mailing_server.public_ip
}

output "http_phishing_mailing_private_ip" {
    value = aws_instance.phishing_mailing_server.private_ip
}

output "http_redirector_public_ip" {
    value = aws_instance.redirector_http_1.public_ip
}

output "http_redirector_private_ip" {
    value = aws_instance.redirector_http_1.private_ip
}

output "http_redirector_url" {
    value = "https://${var.server_name}/"
}

output "covenant_url" {
    value = "https://${var.covenant_server_name}:7443/covenantuser/login"
}

output "http_phishing_application_url" {
    value = "https://${var.server_name}/admin/login/"
}

output "http_phishing_mailing_server_url" {
    value = "https://mail.${var.email_server_name}/iredmail/"
}
