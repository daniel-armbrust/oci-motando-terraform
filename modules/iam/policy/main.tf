#
# modules/iam/policy/main.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_policy
#

resource "oci_identity_policy" "policy" {    
    compartment_id = var.compartment_id
    description = var.description
    name = var.name
    statements = var.statements
    version_date = var.version_date
}