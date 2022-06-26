#
# modules/oke/node_pool/main.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_node_pool
#

resource "oci_containerengine_node_pool" "node_pool" {    
    name = var.node_pool_name
    compartment_id = var.compartment_id
    cluster_id = var.cluster_id    
    
    kubernetes_version = var.kubernetes_version
    
    node_shape = var.shape
  
    node_config_details {       
        
        placement_configs {            
            availability_domain = var.ad_name
            subnet_id = var.subnet_id            
        }
        
        is_pv_encryption_in_transit_enabled = var.pv_encryption_in_transit_enabled        
        nsg_ids = var.nsg_ids
        size = var.nodes
    }   
    
    node_source_details {    
        image_id = var.image_id
        source_type = var.source_type
        boot_volume_size_in_gbs = var.boot_volume_gbs
    }

    node_shape_config {    
        memory_in_gbs = var.gbs_memory
        ocpus = var.ocpus
    }
    
    ssh_public_key = var.ssh_public_key        

    #node_metadata = {
    #   user_data = base64encode(var.cloudinit_script)
    #}
}