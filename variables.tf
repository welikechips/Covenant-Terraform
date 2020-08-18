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