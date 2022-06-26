#
# modules/oke/node_pool/providers.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_node_pool
#

terraform {
  required_providers {      
    oci = {
      source = "hashicorp/oci"
    }
  }
}