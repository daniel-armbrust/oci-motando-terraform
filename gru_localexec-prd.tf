#
# gru_localexec-prd.tf
#

#-------------------------------
# PRODUCTION
#-------------------------------

resource "null_resource" "gru_oke-kubectl-config_prd" {
 
    provisioner "local-exec" {
        command = "./add_kubectl_config.sh '${module.gru_oke-cluster_prd.id}'"
        working_dir = "./scripts"
        on_failure = fail
    }     

    provisioner "local-exec" {
        when = destroy
        command = "./del_kubectl_config.sh"
        working_dir = "./scripts"
        on_failure = continue
    }     

    depends_on = [       
        module.gru_oke-cluster_prd
    ]  
}

resource "null_resource" "gru_oke-config-map_prd" {
 
    provisioner "local-exec" {
        command = "./add_configmap.sh '${local.gru_objectstorage_ns}' '${module.cmp_motando-nosql.id}' '${module.gru_vault.crypto_endpoint}' '${module.gru_motando-aes-mke.id}' '${module.gru_motando_csrf-secret-key.id}'"
        working_dir = "./scripts"
        on_failure = fail
    }     

    provisioner "local-exec" {
        when = destroy
        command = "./del_configmap.sh"
        working_dir = "./scripts"
        on_failure = continue
    }     

    depends_on = [       
        module.gru_oke-cluster_prd,
        null_resource.gru_oke-kubectl-config_prd
    ]  
}

resource "null_resource" "gru_oke-secret_prd" {
 
    provisioner "local-exec" {
        command = "./add_secret.sh '${var.ocir_user}' '${var.ocir_auth_token}' '${local.gru_objectstorage_ns}'"
        working_dir = "./scripts"
        on_failure = fail
    }     

    provisioner "local-exec" {
        when = destroy
        command = "./del_secret.sh"
        working_dir = "./scripts"
        on_failure = continue
    }     

    depends_on = [       
        module.gru_oke-cluster_prd,
        null_resource.gru_oke-kubectl-config_prd
    ]  
}