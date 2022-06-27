#
# dynamicgroups.tf
#

#---------------------------
# Dynamic Groups
#---------------------------

module "dyngrp_motando" {
    source = "./modules/iam/dynamicgroup"

    providers = {
       oci = oci.home_region
    }
    
    tenancy_id = var.tenancy_id

    name = "motando-dyngrp-funcs"    
    description = "Grupo dinâmico que concede acesso ao OKE."

    matching_rule = <<EOS
       ANY {        
         resource.compartment.id = '${module.cmp_motando-oke.id}'
       }
    EOS
}