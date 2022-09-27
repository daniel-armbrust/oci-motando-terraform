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

    name = "motando-dyngrp-oke"    
    description = "Grupo dinâmico que concede acesso ao OKE."

    matching_rule = "All {instance.compartment.id = '${module.cmp_motando-oke.id}'}"
}

module "dyngrp_motando-functions" {
    source = "./modules/iam/dynamicgroup"

    providers = {
       oci = oci.home_region
    }
    
    tenancy_id = var.tenancy_id

    name = "motando-dyngrp-funcs"    
    description = "Grupo dinâmico que concede acesso as Funções."

    matching_rule = <<EOS
       ALL {
         resource.type = 'fnfunc',
         resource.compartment.id = '${module.cmp_motando-functions.id}'
       }
    EOS
}