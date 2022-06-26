#
# modules/network/load_balancer/certificate/variables.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/load_balancer_certificate
#

variable "name" {
    description = "(Required) A friendly name for the certificate bundle. It must be unique and it cannot be changed."
    type = string    
}

variable "load_balancer_id" {
    description = "(Required) The OCID of the load balancer on which to add the certificate bundle."
    type = string
}

variable "certificate" {
    description = "(Optional) The public certificate, in PEM format, that you received from your SSL certificate provider."
    type = string
}

variable "private_key" {
    description = "(Optional) The SSL private key for your certificate, in PEM format."
    type = string
    sensitive = true
}

variable "intermediate_certificates" {
    description = "(Optional) The Certificate Authority certificate, or any interim certificate, that you received from your SSL certificate provider."
    type = string
}