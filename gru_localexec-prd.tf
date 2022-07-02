#
# gru_localexec-prd.tf
#

#-------------------------------
# PRODUCTION
#-------------------------------

resource "null_resource" "gru_bucket_data-estado_cidade_prd" {        

    triggers = {
       bucket_name = module.gru_bucket-estado_cidade_prd.name
    }

    provisioner "local-exec" {
        command = "./add_bucket_data.sh '${module.gru_bucket-estado_cidade_prd.name}' '../data/json/estado_cidade/'"
        working_dir = "./scripts"
        on_failure = fail
    }     

    provisioner "local-exec" {
        when = destroy
        command = "./del_bucket_data.sh '${self.triggers.bucket_name}'"
        working_dir = "./scripts"
        on_failure = fail
    }     

    depends_on = [       
        module.gru_bucket-estado_cidade_prd
    ]  
}

resource "null_resource" "gru_oke-kubectl-setup_prd" {
 
    provisioner "local-exec" {
        command = "./add_kubectl_config.sh '${module.gru_oke-cluster_prd.id}'"
        working_dir = "./scripts"
        on_failure = fail
    }     

    provisioner "local-exec" {
        when = destroy
        command = "./del_kubectl_config.sh"
        working_dir = "./scripts"
        on_failure = fail
    }     

    depends_on = [       
        module.gru_oke-cluster_prd
    ]  
}