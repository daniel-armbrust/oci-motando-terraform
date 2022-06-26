#
# modules/iam/compartment/outputs.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/identity_compartment
#

output "id" {
    value = oci_identity_compartment.compartment.id
}

output "name" {
    value = oci_identity_compartment.compartment.name
}