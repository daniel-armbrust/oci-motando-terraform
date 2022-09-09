#
# gru_compute-prd.tf
#

#---------------------------
# PRODUCTION
#---------------------------

#-------------------
# NGINX A, B
#-------------------

/*
module "gru_nginx-1-motando-prd" {
    source = "./modules/compute"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-compute.id
    display_name = "gru_nginx-1-motando-prd"
    hostname = "gru-nginx-1-motando-prd"

    subnet_id = module.gru_subprv-backend_vcn-prd.id
    ad_name = local.ads.gru_ad1_name
    fd_name = local.fds.gru_fd1_name

    shape = "VM.Standard.E3.Flex"        
    image_id = local.compute_image_id.gru.ol8
    gbs_memory = "4"
    ocpus = "2"    

    enable_bastion_plugin = true

    ssh_public_keys = file("./ssh_keys/nginx-motando-prd.pubkey")
    cloudinit_script = file("./scripts/orlinux_init.sh")
}

module "gru_nginx-2-motando-prd" {
    source = "./modules/compute"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-compute.id
    display_name = "gru_nginx-2-motando-prd"
    hostname = "gru-nginx-2-motando-prd"

    subnet_id = module.gru_subprv-backend_vcn-prd.id
    ad_name = local.ads.gru_ad1_name
    fd_name = local.fds.gru_fd3_name

    shape = "VM.Standard.E3.Flex"        
    image_id = local.compute_image_id.gru.ol8
    gbs_memory = "4"
    ocpus = "2"    

    enable_bastion_plugin = true

    ssh_public_keys = file("./ssh_keys/nginx-motando-prd.pubkey")
    cloudinit_script = file("./scripts/orlinux_init.sh")
}
*/