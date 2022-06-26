#
# modules/network/dns/zone/main.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/dns_zone
#

resource "oci_dns_zone" "zone" {    
    count = var.scope == null ? 1 : 0

    compartment_id = var.compartment_id
    name = var.name
    zone_type = var.zone_type
    scope = var.scope        
}

resource "oci_dns_zone" "private_zone" {    
    count = var.scope == "PRIVATE" ? 1 : 0

    compartment_id = var.compartment_id
    name = var.name
    zone_type = var.zone_type
    scope = var.scope        
    view_id = var.view_id
}