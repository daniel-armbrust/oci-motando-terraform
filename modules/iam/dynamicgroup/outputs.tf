#
# modules/iam/dynamicgroups/outputs.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_dynamic_group
#

output "id" {
    value = oci_identity_dynamic_group.dynamic_group.id
}

output "name" {
    value = oci_identity_dynamic_group.dynamic_group.name
}