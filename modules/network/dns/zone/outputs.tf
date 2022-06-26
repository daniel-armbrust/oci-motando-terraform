#
# modules/network/dns/zone/outputs.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/dns_zone
#

output "id" {
    value = join("", oci_dns_zone.zone.*.id, oci_dns_zone.private_zone.*.id)
}

output "name" {
    value = join("", oci_dns_zone.zone.*.name, oci_dns_zone.private_zone.*.name)
}