#
# gru_logging.tf
#

#-------------------
# Logging
#-------------------

module "gru_motando-logging_group" {
    source = "./modules/logging/loggroup"
   
    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando.id
    display_name = "motando_loggroup"
}