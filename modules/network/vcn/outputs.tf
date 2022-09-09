#
# modules/network/vcn/outputs.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_vcn
#

output "id" {
    value = oci_core_vcn.vcn.id
}

output "dns_resolver_id" {
    value = data.oci_core_vcn_dns_resolver_association.vcn_dns_resolver_association.dns_resolver_id

    depends_on = [
        oci_core_vcn.vcn
    ]
}

#
# This data source provides the Vcn Dns Resolver Association.
# https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_vcn_dns_resolver_association
#
data "oci_core_vcn_dns_resolver_association" "vcn_dns_resolver_association" {        
    vcn_id = oci_core_vcn.vcn.id    
}