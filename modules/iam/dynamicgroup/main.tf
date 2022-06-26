#
# modules/iam/dynamicgroup/main.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_dynamic_group
#

resource "oci_identity_dynamic_group" "dynamic_group" {    
    compartment_id = var.tenancy_id
    description = var.description
    matching_rule = var.matching_rule
    name = var.name
}