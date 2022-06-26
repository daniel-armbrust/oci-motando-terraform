#
# modules/network/dns/record/outputs.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/dns_record
#

output "rdata" {
    value = join("", oci_dns_rrset.dns_record.items.*.rdata)   
}

output "domain" {
    description = "The fully qualified domain name where the record can be located."
    value = oci_dns_rrset.dns_record.domain
}