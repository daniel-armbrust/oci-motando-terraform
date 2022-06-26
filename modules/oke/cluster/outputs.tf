#
# modules/oke/cluster/outputs.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_cluster
#

output "id" {
    description = "The OCID of the cluster."
    value = oci_containerengine_cluster.oke_cluster.id
}

output "private_endpoints" {
    description = "The private native networking Kubernetes API server endpoint."
    value = join("", oci_containerengine_cluster.oke_cluster.endpoints.*.private_endpoint)
}

output "public_endpoints" {
    description = "The public native networking Kubernetes API server endpoint, if one was requested."
    value = join("", oci_containerengine_cluster.oke_cluster.endpoints.*.public_endpoint)
}

output "kubernetes_version" {
    description = "The version of Kubernetes running on the cluster masters."
    value = oci_containerengine_cluster.oke_cluster.kubernetes_version
}

output "cluster_name" {
    description = "The name of the cluster."
    value = oci_containerengine_cluster.oke_cluster.name
}

output "cluster_state" {
    description = "The state of the cluster masters."
    value = oci_containerengine_cluster.oke_cluster.state
}

