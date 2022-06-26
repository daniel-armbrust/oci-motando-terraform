#
# modules/network/dns/view/variables.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/dns_view
#

variable "compartment_id" {
    description = "(Required) (Updatable) The OCID of the compartment the resource belongs to."
    type = string    
}

variable "display_name" {
    description = "(Optional) (Updatable) The display name of the view. "
    type = string    
}

variable "scope" {
    description = "(Required) Value must be PRIVATE when creating a view for private zones."
    type = string
    default = "PRIVATE"
}