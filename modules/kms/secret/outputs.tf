#
# modules/kms/secret/outputs.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/vault_secret
#

output "id" {
    value = join("", oci_vault_secret.secret_expiry_rule.*.id, oci_vault_secret.secret_reuse_rule.*.id)    
}