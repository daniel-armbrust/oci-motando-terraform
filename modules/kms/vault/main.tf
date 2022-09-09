#
# modules/kms/vault/main.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/kms_vault
#

resource "oci_kms_vault" "vault_protected" {    
   count = var.prevent_destroy ? 1 : 0

   compartment_id = var.compartment_id
   display_name = var.display_name
   vault_type = var.type

   lifecycle {
       prevent_destroy = true
   } 
}

resource "oci_kms_vault" "vault" {    
   count = var.prevent_destroy ? 0 : 1

   compartment_id = var.compartment_id
   display_name = var.display_name
   vault_type = var.type 
}