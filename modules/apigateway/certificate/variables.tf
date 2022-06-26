#
# modules/apigateway/certificate/variables.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/apigateway_certificate
#

variable "compartment_id" {
    description = "(Required) (Updatable) The OCID of the compartment in which the resource is created."
    type = string    
}

variable "display_name" {
    description = "(Optional) (Updatable) A user-friendly name."
    type = string
    default = "api-gw-cert"
}

variable "certificate" {
    description = "(Required) The data of the leaf certificate in pem format."
    type = string
}

variable "private_key" {
    description = "(Required) The private key associated with the certificate in pem format."
    type = string
    sensitive = true
}

variable "intermediate_certificates" {
    description = "(Optional) The intermediate certificate data associated with the certificate in pem format."
    type = string
}
