#
# modules/kms/secret/providers.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/vault_secret
#

terraform {
  required_providers {      
    oci = {
      source = "hashicorp/oci"
    }
  }
}