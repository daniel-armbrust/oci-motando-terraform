#
# gru_objectstorage.tf
#

#---------------------------
# PRODUCTION
#---------------------------

#-------------------
# Bucket: Anuncio
#-------------------
module "gru_bucket_motando_anuncio" {
    source = "./modules/objectstorage"
   
    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando.id
    bucket_name = "motando_bucket_anuncio"
    bucket_namespace = local.gru_objectstorage_ns        
    access_type = "ObjectReadWithoutList"
}

#-------------------
# Bucket: Usuario
#-------------------
module "gru_bucket_motando_usuario" {
    source = "./modules/objectstorage"
   
    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando.id
    bucket_name = "motando_bucket_usuario"
    bucket_namespace = local.gru_objectstorage_ns        
    access_type = "ObjectReadWithoutList"
}