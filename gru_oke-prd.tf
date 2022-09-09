#
# gru_oke-prd.tf
#

#---------------------------
# PRODUCTION
#---------------------------

#-------------------
# OKE Cluster
#-------------------

module "gru_oke-cluster_prd" {
    source = "./modules/oke/cluster"
   
    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-oke.id
    cluster_name = "motando_oke-cluster"

    kubernetes_version = "v1.23.4"
        
    vcn_id = module.gru_vcn-prd.id
    
    lb_subnet_ids = [module.gru_subprv-okelb_vcn-prd.id]

    pods_cidr = "10.244.0.0/16"
    services_cidr = "10.96.0.0/16"

    dashboard_enabled = true
    tiller_enabled = false
    pod_security_policy_enabled = false

    control_plane_enable_pubip = true
    control_plane_subnet_id = module.gru_subpub-okectlpln_vcn-prd.id
}

#-------------------
# OKE Node Pool
#-------------------

module "gru_oke-nodepool-1_prd" {
    source = "./modules/oke/node_pool"
   
    providers = {
       oci = oci.gru
    }

    cluster_id = module.gru_oke-cluster_prd.id
    kubernetes_version = module.gru_oke-cluster_prd.kubernetes_version

    compartment_id = module.cmp_motando-oke.id
    node_pool_name = "motando_oke-nodepool-1"
    
    ad_name = local.ads.gru_ad1_name
    subnet_id = module.gru_subprv-backend_vcn-prd.id

    nodes = 3    

    image_id = local.compute_image_id.gru.ol85-oke
    shape = "VM.Standard.E3.Flex"    
    gbs_memory = "4"
    ocpus = "2"
    boot_volume_gbs = 100
    ssh_public_key = file("./ssh_keys/oke-node-prd.pubkey")    

    # TODO: script to change linux timezone
    #cloudinit_script = file("./scripts/orlinux_init.sh")
}