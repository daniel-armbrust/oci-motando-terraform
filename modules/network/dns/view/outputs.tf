#
# modules/network/dns/view/outputs.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/dns_view
#

output "id" {    
    value = oci_dns_view.dns_view.id
}