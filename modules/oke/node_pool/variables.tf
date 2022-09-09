#
# modules/oke/node_pool/variables.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_node_pool
#

variable "node_pool_name" {
    description = "(Required) (Updatable) The name of the node pool."
    type = string
}

variable "compartment_id" {
    description = "(Required) The OCID of the compartment in which the node pool exists."
    type = string    
}

variable "cluster_id" {
    description = "(Required) The OCID of the cluster to which this node pool is attached."
    type = string    
}

variable "kubernetes_version" {
    #
    # https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengaboutk8sversions.htm#Supported_Versions_of_Kubernetes
    #
    description = "(Required) (Updatable) The version of Kubernetes to install on the nodes in the node pool."
    type = string
    default = "v1.24.1"
}

variable "pv_encryption_in_transit_enabled" {
    description = "(Optional) (Updatable) Whether to enable in-transit encryption for the data volume's paravirtualized attachment. This field applies to both block volumes and boot volumes."
    type = bool
    default = false
}

variable "nsg_ids" {
    description = "(Optional) (Updatable) The OCIDs of the Network Security Group(s) to associate nodes for this node pool with."
    type = list(string)
    default = null
}

variable "ad_name" {
    description = "(Required) (Updatable) The availability domain in which to place nodes."
    type = string
}

variable "subnet_id" {
    description = "(Required) (Updatable) The OCID of the subnet in which to place nodes."
    type = string
}

variable "nodes" {
    description = "(Required) (Updatable) The number of nodes that should be in the node pool. "
    type = number
    default = 3
}

variable "image_id" {
    description = "(Required) (Updatable) The OCID of the image used to boot the node."
    type = string
}

variable "shape" {
    description = "(Required) (Updatable) The name of the node shape of the nodes in the node pool."
    type = string
}

variable "gbs_memory" {
    description = "(Optional) (Updatable) The total amount of memory available to each node, in gigabytes."
    type = string    
}

variable "ocpus" {
    description = " (Optional) (Updatable) The total number of OCPUs available to each node in the node pool."
    type = string    
}

variable "source_type" {
    description = "(Required) (Updatable) The source type for the node. Use IMAGE when specifying an OCID of an image."
    type = string
    default = "IMAGE"
}

variable "boot_volume_gbs" {
    description = "(Optional) (Updatable) The size of the boot volume in GBs. Minimum value is 50 GB."
    type = number
    default = 50
}

variable "ssh_public_key" {
    description = "(Optional) (Updatable) The SSH public key on each node in the node pool on launch."
    type = string
    default = null
}

variable "cloudinit_script" {
    description = "Script filename executed by Cloud-Init."
    type = string
    default = ""
}