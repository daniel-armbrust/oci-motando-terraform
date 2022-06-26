#
# modules/network/dns/view/main.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/dns_view
#

resource "oci_dns_view" "dns_view" {    
    compartment_id = var.compartment_id
    scope = var.scope
    display_name = var.display_name    
}