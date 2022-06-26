#
# modules/iam/dynamicgroup/variables.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_dynamic_group
#

variable "tenancy_id" {
    description = "(Required) The OCID of the tenancy containing the dynamic group."
    type = string    
}

variable "name" {
    description = "(Required) The name you assign to the dynamic group during creation. The name must be unique across all groups in the tenancy and cannot be changed."
    type = string
} 

variable "description" {
    description = "(Required) (Updatable) The description you assign to the dynamic group during creation."
    type = string
}

variable "matching_rule" {
    description = "(Required) (Updatable) The matching rule of the dynamic group."
    type = string
}