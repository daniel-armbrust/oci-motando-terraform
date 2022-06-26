#
# modules/iam/compartment/variables.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/identity_compartment
#

variable "parent_compartment_id" {
    description = "(Required) (Updatable) The OCID of the parent compartment containing the compartment."
    type = string    
}

variable "name" {
    description = "(Required) (Updatable) The name of the compartment. The name must be unique across all compartments in the parent compartment."
    type = string
} 

variable "description" {
    description = "(Required) (Updatable) The description you assign to the compartment during creation."
    type = string
}