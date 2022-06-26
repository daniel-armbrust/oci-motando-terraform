#
# modules/network/dns/record/main.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/dns_record
#

resource "oci_dns_rrset" "dns_record" {
    compartment_id = var.compartment_id

    zone_name_or_id = var.zone_id

    domain = var.domain    
    rtype = var.rtype    

    items {
        domain = var.domain
        rdata = var.rdata
        rtype = var.rtype
        ttl = var.ttl
    }        
}