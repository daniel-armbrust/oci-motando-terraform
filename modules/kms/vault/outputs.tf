#
# modules/kms/vault/outputs.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/kms_vault
#

output "id" {
    value = join("", oci_kms_vault.vault_protected.*.id,  oci_kms_vault.vault.*.id)
}

output "crypto_endpoint" {
    value = join("", oci_kms_vault.vault_protected.*.crypto_endpoint,  oci_kms_vault.vault.*.crypto_endpoint)    
}

output "is_primary" {
    value = join("", oci_kms_vault.vault_protected.*.is_primary,  oci_kms_vault.vault.*.is_primary)        
}

output "type" {
    value = join("", oci_kms_vault.vault_protected.*.vault_type,  oci_kms_vault.vault.*.vault_type)            
}

output "mgmt_endpoint" {
    value = join("", oci_kms_vault.vault_protected.*.management_endpoint,  oci_kms_vault.vault.*.management_endpoint)            
}