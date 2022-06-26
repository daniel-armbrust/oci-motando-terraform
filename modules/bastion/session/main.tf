#
# modules/bastion/session/main.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/bastion_session
#

resource "oci_bastion_session" "bastion_session" {
    display_name = var.display_name
    bastion_id = var.bastion_id

    key_details {        
       public_key_content = var.ssh_public_key
    }

    target_resource_details {        
       session_type = "MANAGED_SSH"
       target_resource_id = var.target_id
       target_resource_port = var.target_port
       target_resource_operating_system_user_name = var.target_username
    }
    
    key_type = "PUB"
    session_ttl_in_seconds = var.session_ttl
}