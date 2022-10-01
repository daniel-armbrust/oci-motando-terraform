#
# gru_functions.tf
#

#--------------------
# Application
#--------------------

/*
module "gru_appl-fn_prd" {
    source = "./modules/functions/application"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-functions.id
    display_name = "motando-appl-fn_prd"

    app_config = {
        "MOTANDO_API_HOSTNAME" = "api.ocibook.local",
        "NOSQL_CMP" = module.cmp_motando-nosql.id,   
        "MOTANDO_ANUNCIO_TABLE_NAME" = module.gru_table_motando_anuncio.name,          
        "MOTANDO_ANUNCIO_BUCKET_NAME" = module.gru_bucket-anuncio_prd.name,
        "MOTANDO_ANUNCIO_TMP_BUCKET_NAME" = module.gru_bucket-anuncio-tmp_prd.name,
        "MOTANDO_IMG_TMP_BUCKET_NAME" = module.gru_bucket-anuncio-imgtmp_prd.name
    }

    subnet_ids = [
        module.gru_subprv-backend_vcn-prd.id
    ]
}
*/