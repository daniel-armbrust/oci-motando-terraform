#
# modules/iam/policy/variables.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_policy
#

variable "compartment_id" {
    description = "(Required) The OCID of the compartment containing the policy."
    type = string    
}

variable "name" {
    description = "(Required) The name you assign to the policy during creation. The name must be unique across all policies in the tenancy and cannot be changed."
    type = string
} 

variable "description" {
    description = "(Required) (Updatable) The description you assign to the policy during creation. "
    type = string
}

variable "statements" {
    description = "(Required) (Updatable) An array of policy statements written in the policy language."
    type = list(string)
}

variable "version_date" {
    description = "(Optional) (Updatable) The version of the policy."
    type = string
    default = null
}