#
# modules/network/dns/zone/variables.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/dns_zone
#

variable "compartment_id" {
    description = "(Required) (Updatable) The OCID of the compartment the resource belongs to."
    type = string    
}

variable "name" {
    description = "(Required) The name of the zone."
    type = string 
}

variable "scope" {
    description = "(Optional) Specifies to operate only on resources that have a matching DNS scope. This value will be null for zones in the global DNS and PRIVATE when creating a private zone."
    type = string
    default = null
}

variable "view_id" {
    description = "(Optional) The OCID of the private view containing the zone. This value will be null for zones in the global DNS, which are publicly resolvable and not part of a private view."
    type = string
    default = null
}

variable "zone_type" {
    description = "(Required) The type of the zone. Must be either PRIMARY or SECONDARY. SECONDARY is only supported for GLOBAL zones."
    type = string
    
    validation {
       condition = can(regex("^(PRIMARY|SECONDARY)$", var.zone_type))
       error_message = "The ZONE TYPE must be PRIMARY or SECONDARY. SECONDARY is only supported for GLOBAL zones."
    }

    default = "PRIMARY"
}