#
# modules/oke/cluster/variables.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_cluster
#

variable "cluster_name" {
    description = "(Required) (Updatable) The name of the cluster. Avoid entering confidential information."
    type = string
}

variable "compartment_id" {
    description = "(Required) The OCID of the compartment in which to create the cluster."
    type = string    
}

variable "vcn_id" {
    description = "(Required) The OCID of the virtual cloud network (VCN) in which to create the cluster."
    type = string    
}

variable "pods_cidr" {
    description = "(Optional) The CIDR block for Kubernetes pods. Optional, defaults to 10.244.0.0/16."
    type = string
    default = "10.244.0.0/16"
}

variable "services_cidr" {
    description = "(Optional) The CIDR block for Kubernetes services. Optional, defaults to 10.96.0.0/16."
    type = string
    default = "10.96.0.0/16"
}

variable "lb_subnet_ids" {
    description = "(Optional) The OCIDs of the subnets used for Kubernetes services load balancers."
    type = list(string)
    default = null
}

variable "img_policy_enabled" {
    description = "(Optional) (Updatable) Whether the image verification policy is enabled."
    type = bool
    default = false
}

variable "kubernetes_version" {
    #
    # https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengaboutk8sversions.htm#Supported_Versions_of_Kubernetes
    #
    description = "(Required) (Updatable) The version of Kubernetes to install into the cluster masters."
    type = string
    default = "v1.23.4"

    validation {
       condition = can(regex("^(v1.20.8|v1.20.11|v1.21.5|v1.22.5|v1.23.4)$", var.kubernetes_version))
       error_message = "Incompatible Kubernetes version."
    }   
}
  
variable "dashboard_enabled" {
    description = "(Optional) Whether or not to enable the Kubernetes Dashboard add-on."
    type = bool
    default = true
}

variable "tiller_enabled" {
    description = "(Optional) Whether or not to enable the Tiller add-on."
    type = bool
    default = false
}

variable "pod_security_policy_enabled" {
    description = "(Optional) (Updatable) Whether or not to enable the Pod Security Policy admission controller."
    type = bool
    default = false
}

variable "control_plane_enable_pubip" {
    description = "(Optional) Whether the cluster should be assigned a public IP address."
    type = bool
    default = false
}

variable "control_plane_nsg_ids" {
    description = "(Optional) A list of the OCIDs of the network security groups (NSGs) to apply to the cluster endpoint."
    type = list(string)
    default = null
}

variable "control_plane_subnet_id" {
    description = "(Optional) The OCID of the regional subnet in which to place the Cluster endpoint."
    type = string
    default = null
}
