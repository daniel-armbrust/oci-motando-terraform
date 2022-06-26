#
# modules/network/dns/resolver/main.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/dns_resolver
#

resource "oci_dns_resolver" "dns_resolver" {    
    compartment_id = var.compartment_id
    display_name = var.display_name
    resolver_id = var.resolver_id
    scope = "PRIVATE"
    
    attached_views {        
        view_id = var.view_id
    }
}