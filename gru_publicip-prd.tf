#
# gru_publicip-prd.tf
#

#---------------------------
# PRODUCTION
#---------------------------

#-------------------
# Public IP
#-------------------

module "gru_lbpublicip-1_prd" { 
   source = "./modules/network/public_ip"

   providers = {
       oci = oci.gru
   }

   compartment_id = module.cmp_motando-network.id
   display_name = "gru_lbpublicip-1_prd"
   lifetime = "RESERVED"
}