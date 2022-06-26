#
# modules/oke/cluster/providers.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_cluster
#

terraform {
  required_providers {      
    oci = {
      source = "hashicorp/oci"
    }
  }
}