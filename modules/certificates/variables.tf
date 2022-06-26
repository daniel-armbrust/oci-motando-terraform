#
# modules/certificates/variables.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/certificates_management_certificate
#

variable "compartment_id" {
    description = "(Required) (Updatable) The OCID of the compartment where you want to create the certificate."
    type = string    
}

variable "name" {
    description = "(Required) A user-friendly name for the certificate."
    type = string    
}

variable "certificate_description" {
    description = "(Optional) (Updatable) A brief description of the certificate. "
    type = string    
    default = null
}

variable "config_type" {
    description = "(Required) (Updatable) The origin of the certificate."

    type = string

    validation {
       condition = can(regex("^(IMPORTED|ISSUED_BY_INTERNAL_CA|MANAGED_EXTERNALLY_ISSUED_BY_INTERNAL_CA)$", var.config_type))
       error_message = "The config_type can be one of these values: IMPORTED, ISSUED_BY_INTERNAL_CA or MANAGED_EXTERNALLY_ISSUED_BY_INTERNAL_CA."
    }   

    default = "IMPORTED"
}

variable "certificate" {
    description = "(Required when config_type=IMPORTED) (Updatable) The certificate (in PEM format) for the imported certificate."
    type = string
}

variable "private_key" {
    description = "(Required when config_type=IMPORTED) (Updatable) The private key (in PEM format) for the imported certificate."
    type = string
    sensitive = true
}

variable "intermediate_certificates" {
    description = "(Required when config_type=IMPORTED) (Updatable) The certificate chain (in PEM format) for the imported certificate."
    type = string
}