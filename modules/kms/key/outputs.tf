#
# modules/kms/key/outputs.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/kms_key
#

output "id" {
    value = join("", oci_kms_key.key_protected.*.id,  oci_kms_key.key.*.id)
}

output "vault_id" {
    value = join("", oci_kms_key.key_protected.*.vault_id,  oci_kms_key.key.*.vault_id)
}

output "current_key_version" {
    value = join("", oci_kms_key.key_protected.*.current_key_version,  oci_kms_key.key.*.current_key_version)
}