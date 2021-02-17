variable "instance_type" {
    type = string
    description = "Instance type for the instances"
}

variable "region" {
    type = string
    description = "The region where the instances are built"
}

variable "ami_id" {
    type        = string
    description = "The id of the machine image (AMI) to use for the server."
}

variable "availability_zones" {
    type = list
}

variable "access_cidrs" {
    type = list
    description = "The ip address cidrs you are using to access c2 infrastructure."
}

variable "only_allow_access_to_cidrs" {
    type = list
    description = "The ip address cidrs you are using to access redirectors endpoints."
}

variable "subnet" {
    type = string
    description = "The local subnet for the instances"
}

variable "env" {
    type = string
}

variable "server_name" {
    type = string
    description = "The ssl cert server name"
}

variable "covenant_server_name" {
    type = string
    description = "The server name for the covenant server"
}

variable "spoof_server_address" {
    type = string
    description = "The url address that you are mimicking"  
}

variable "hosted_zone_id" {
    type = string
    description = "The hosted zone id for the redirector server"
}

variable "covenant_hosted_zone_id" {
    type = string
    description = "The hosted zone id for the covenant server"
}

variable "contact_email" {
    type = string
    description = "contact email for certbot renewals"
}

variable "certificate_export_password" {
    type = string
    description = "password to export the ssl generated certificate"
}

variable "ford_github_user_name" {
    type = string
    description = "username to pull ford github private repositories"
}

variable "ford_github_password" {
    type = string
    description = "password to pull ford github private repositories"
}

variable "django_user_name" {
    type = string
    description = "username for phishing backend"
}

variable "django_email" {
    type = string
    description = "email for phishing backend"
}

variable "email_server_name" {
    type = string
    description = "email server domain name"
}

variable "email_server_hosted_zone_id" {
    type = string
    description = "email server hosted zone id"
}