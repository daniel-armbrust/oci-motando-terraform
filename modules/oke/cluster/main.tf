#
# modules/oke/cluster/main.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_cluster
#

resource "oci_containerengine_cluster" "oke_cluster" {
    name = var.cluster_name
    compartment_id = var.compartment_id
    kubernetes_version = var.kubernetes_version
    
    vcn_id = var.vcn_id

    endpoint_config {        
        is_public_ip_enabled = var.control_plane_enable_pubip
        nsg_ids = var.control_plane_nsg_ids
        subnet_id = var.control_plane_subnet_id
    }
    
    image_policy_config {        
        is_policy_enabled = var.img_policy_enabled        
    }
    
    options {        
        add_ons {            
            is_kubernetes_dashboard_enabled = var.dashboard_enabled
            is_tiller_enabled = var.tiller_enabled
        }

        admission_controller_options {
            is_pod_security_policy_enabled = var.pod_security_policy_enabled
        }

        kubernetes_network_config {            
            pods_cidr = var.pods_cidr
            services_cidr = var.services_cidr
        }     
       
        service_lb_subnet_ids = var.lb_subnet_ids
    }
}
