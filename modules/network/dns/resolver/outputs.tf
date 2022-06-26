#
# modules/network/dns/resolver/outputs.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/dns_resolver
#

output "id" {
    description = "The OCID of the resolver."
    value = oci_dns_resolver.dns_resolver.id
}

output "attached_vcn_id" {
    description = "The OCID of the attached VCN."
    value = oci_dns_resolver.dns_resolver.attached_vcn_id
}

