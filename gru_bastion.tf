#
# gru_bastion.tf
#

#---------------------------
# BASTION
#---------------------------

module "gru_bastion" {
    source = "./modules/bastion/bastion"
    
    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-network.id
    display_name = "GruBastionMotando"
    target_subnet_id = module.gru_subprv-backend_vcn-prd.id
    client_cidr_list = [local.my_public_ip]    
}

/*
module "gru_nginx-1-motando-prd_bastion_session" {
    source = "./modules/bastion/session"

    providers = {
       oci = oci.gru
    }

    display_name = "gru_nginx-1-motando-prd_bastion_session"
    bastion_id = module.gru_bastion.id

    target_id = module.gru_nginx-1-motando-prd.id
    target_username = "opc"
    ssh_public_key = file("./ssh_keys/nginx-motando-prd.pubkey")  
    session_ttl = 3600  
}

module "gru_nginx-2-motando-prd_bastion_session" {
    source = "./modules/bastion/session"

    providers = {
       oci = oci.gru
    }

    display_name = "gru_nginx-2-motando-prd_bastion_session"
    bastion_id = module.gru_bastion.id

    target_id = module.gru_nginx-2-motando-prd.id
    target_username = "opc"
    ssh_public_key = file("./ssh_keys/nginx-motando-prd.pubkey")
    session_ttl = 3600
}
*/