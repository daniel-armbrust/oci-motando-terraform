#
# modules/kms/key/variables.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/kms_vault
#

variable "compartment_id" {
    description = "(Required) (Updatable) The OCID of the compartment where you want to create the master encryption key."
    type = string    
}

variable "display_name" {
    description = "(Required) (Updatable) A user-friendly name for the key."
    type = string
    default = "vault_key"
}

variable "key_algorithm" {
    description = "(Required) The algorithm used by a key's key versions to encrypt or decrypt."
    type = string

    # https://docs.oracle.com/en-us/iaas/api/#/en/key/release/datatypes/KeyShape
    validation {
       condition = can(regex("^(AES|RSA|ECDSA)$", var.key_algorithm))
       error_message = "The algorithm used by a key must be AES, RSA or ECDSA."
    }   
}

variable "key_length" {
    description = "(Required) The length of the key in bytes, expressed as an integer."
    type = number    
}

variable "mgmt_endpoint" {
    description = "(Required) The service endpoint to perform management operations against."
    type = string
}

variable "protection_mode" {
    description = "(Optional) The key's protection mode indicates how the key persists and where cryptographic operations that use the key are performed."
    type = string
    default = "SOFTWARE"

    # https://docs.oracle.com/en-us/iaas/api/#/en/key/release/datatypes/KeyShape
    validation {
       condition = can(regex("^(HSM|SOFTWARE)$", var.protection_mode))
       error_message = "The key's protection mode to persists and where cryptographic operations are performed must be HSM or SOFTWARE."
    }  
}

variable "prevent_destroy" {    
    type = bool
    default = true
}