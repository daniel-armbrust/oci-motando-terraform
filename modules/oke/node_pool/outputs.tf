#
# modules/oke/node_pool/outputs.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_node_pool
#

output "id" {
    description = "The OCID of the node pool."
    value = oci_containerengine_node_pool.node_pool.id
}

output "cluster_id" {
    description = " The OCID of the cluster to which this node pool is attached."
    value = oci_containerengine_node_pool.node_pool.cluster_id
}