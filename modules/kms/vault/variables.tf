#
# modules/kms/vault/variables.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/kms_vault
#

variable "compartment_id" {
    description = "(Required) (Updatable) The OCID of the compartment where you want to create this vault."
    type = string    
}

variable "display_name" {
    description = "(Required) (Updatable) A user-friendly name for the vault."
    type = string
    default = "vault"
}

variable "type" {
    description = "(Required) The type of vault to create. Each type of vault stores the key with different degrees of isolation and has different options and pricing."
    type = string
    default = "DEFAULT"

    # https://docs.oracle.com/en-us/iaas/api/#/en/key/release/datatypes/CreateVaultDetails
    validation {
       condition = can(regex("^(DEFAULT|VIRTUAL_PRIVATE)$", var.type))
       error_message = "The type of vault to create must be DEFAULT or VIRTUAL_PRIVATE."
    }   
}

variable "prevent_destroy" {    
    type = bool
    default = true
}
