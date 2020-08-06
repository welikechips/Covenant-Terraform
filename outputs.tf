output "covenant_public_ip" {
    value = aws_eip.ip.public_ip
}

output "covenant_private_ip" {
    value = aws_instance.covenant_c2.private_ip
}

output "http_redirector_public_ip" {
    value = aws_instance.redirector_http_1.public_ip
}

output "http_redirector_private_ip" {
    value = aws_instance.redirector_http_1.private_ip
}