#
# policies.tf
#

#---------------------------
# IAM Policies
#---------------------------

module "policies_motando-functions" {
    source = "./modules/iam/policy"

    providers = {
       oci = oci.home_region
    }

    compartment_id = module.cmp_motando.id

    name = "motando-policies"    
    description = "IAM Policies da aplicação Montado."

    statements = [
       "Allow dynamic-group ${module.dyngrp_motando.name} to manage nosql-tables in compartment ${module.cmp_motando-nosql.name}",
       "Allow dynamic-group ${module.dyngrp_motando.name} to read objects in compartment ${module.cmp_motando.name} where target.bucket.name='${module.gru_bucket-estado_cidade_prd.name}'"
    ]
}