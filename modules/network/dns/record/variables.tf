#
# modules/network/dns/record/variables.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/dns_record
#

variable "compartment_id" {
    description = "(Required) (Updatable) The OCID of the compartment the resource belongs to."
    type = string    
}

variable "domain" {
    description = "(Required) The fully qualified domain name where the record can be located. Domain value is case insensitive."
    type = string
}

variable "zone_id" {
    description = "(Required) The name or OCID of the target zone."
    type = string
}

variable "rtype" {
    description = "(Required) The DNS record type, such as A or CNAME."
    type = string
}

variable "rdata" {
    description = "(Optional) (Updatable) The record data."
    type = string
}

variable "ttl" {
    description = "(Optional) (Updatable) The Time To Live for the record, in seconds."
    type = number
    default = 3600
}