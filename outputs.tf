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