#
# modules/kms/key/main.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/kms_key
#

resource "oci_kms_key" "key_protected" {    
   count = var.prevent_destroy ? 1 : 0

   compartment_id = var.compartment_id
   display_name = var.display_name

   key_shape {     
      algorithm = var.key_algorithm
      length = var.key_length
   }

   management_endpoint = var.mgmt_endpoint
   protection_mode = var.protection_mode
 
   lifecycle {
       prevent_destroy = true
   } 
}

resource "oci_kms_key" "key" {    
   count = var.prevent_destroy ? 0 : 1

   compartment_id = var.compartment_id
   display_name = var.display_name

   key_shape {     
      algorithm = var.key_algorithm
      length = var.key_length
   }

   management_endpoint = var.mgmt_endpoint
   protection_mode = var.protection_mode 
}