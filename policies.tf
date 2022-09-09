#
# policies.tf
#

#---------------------------
# IAM Policies
#---------------------------

module "policies_motando" {
    source = "./modules/iam/policy"

    providers = {
       oci = oci.home_region
    }

    compartment_id = var.tenancy_id

    name = "motando-policies"    
    description = "IAM Policies da aplicação Montado."

    #CSM-BR:daniel.armbrust:cmp-motando:cmp-nosql

    statements = [
       "Allow dynamic-group ${module.dyngrp_motando.name} to manage nosql-family in compartment CSM-BR:daniel.armbrust:${module.cmp_motando.name}:${module.cmp_motando-nosql.name}",
       "Allow dynamic-group ${module.dyngrp_motando.name} to read objects in compartment CSM-BR:daniel.armbrust:${module.cmp_motando.name} where any {target.bucket.name='${module.gru_bucket-estado_cidade_prd.name}', target.bucket.name='${module.gru_bucket-moto_prd.name}'}",
       "Allow dynamic-group ${module.dyngrp_motando.name} to use keys in compartment CSM-BR:daniel.armbrust:${module.cmp_motando.name}",
       "Allow dynamic-group ${module.dyngrp_motando.name} to use secret-family in compartment CSM-BR:daniel.armbrust:${module.cmp_motando.name}"
    ]   
}