#
# gru_objectstorage.tf
#

#---------------------------
# PRODUCTION
#---------------------------

#-------------------
# Estado e Cidade
#-------------------
module "gru_bucket-estado_cidade_prd" {
    source = "./modules/objectstorage"
   
    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando.id
    bucket_name = "motando_estado_cidade"
    bucket_namespace = local.gru_objectstorage_ns        
    access_type = "NoPublicAccess"   
}

#-------------------
# Anuncio
#-------------------
module "gru_bucket-anuncio_prd" {
    source = "./modules/objectstorage"
   
    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando.id
    bucket_name = "motando_anuncio"
    bucket_namespace = local.gru_objectstorage_ns        
    access_type = "ObjectReadWithoutList"
}

#-------------------
# Usuario
#-------------------
module "gru_bucket-usuario_prd" {
    source = "./modules/objectstorage"
   
    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando.id
    bucket_name = "motando_usuario"
    bucket_namespace = local.gru_objectstorage_ns        
    access_type = "ObjectReadWithoutList"
}