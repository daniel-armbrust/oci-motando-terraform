#
# gru_functions.tf
#

#--------------------
# Application
#--------------------

module "gru_appl-fn_prd" {
    source = "./modules/functions/application"

    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando-functions.id
    display_name = "motando-appl-fn_prd"

    app_config = {
        "NOSQL_CMP" = module.cmp_motando-nosql.id,      
        "OBJSTR_NAMESPACE" = local.gru_objectstorage_ns,
        "ANUNCIO_BUCKET_NAME" = module.gru_bucket-anuncio_prd.name,
        "ANUNCIO_TMP_BUCKET_NAME" = module.gru_bucket-anuncio-tmp_prd.name,
        "IMAGEM_TMP_BUCKET_NAME" = module.gru_bucket-anuncio-imgtmp_prd.name
    }

    subnet_ids = [
        module.gru_subprv-backend_vcn-prd.id
    ]
}