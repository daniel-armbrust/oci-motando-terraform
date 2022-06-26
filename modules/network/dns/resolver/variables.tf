#
# modules/network/dns/resolver/variables.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/dns_resolver
#

variable "compartment_id" {
    description = " (Optional) (Updatable) The OCID of the owning compartment."
    type = string    
}

variable "display_name" {
    description = "(Optional) (Updatable) The display name of the resolver."
    type = string    
}

variable "resolver_id" {
    description = "(Required) The OCID of the target resolver."
    type = string
}

variable "view_id" {
    description = "(Required) (Updatable) The OCID of the view."
    type = string
}