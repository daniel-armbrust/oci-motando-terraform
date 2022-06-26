#
# modules/iam/compartment/main.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/identity_compartment
#

resource "oci_identity_compartment" "compartment" {    
    compartment_id = var.parent_compartment_id
    description = var.description
    name = var.name

    #enable_delete = true
}