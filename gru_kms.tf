#
# gru_kms.tf
#

module "gru_vault" {
    source = "./modules/kms/vault"
   
    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando.id
    display_name = "gru_vault"

    prevent_destroy = true    
}

module "gru_motando-aes-mke" {
    source = "./modules/kms/key"
   
    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando.id
    display_name = "gru_motando-aes-mke"

    key_algorithm = "AES"
    key_length = 32
    protection_mode = "SOFTWARE"
    mgmt_endpoint = module.gru_vault.mgmt_endpoint

    prevent_destroy = true  
}

module "gru_motando_csrf-secret-key" {
    source = "./modules/kms/secret"
   
    providers = {
       oci = oci.gru
    }

    compartment_id = module.cmp_motando.id
    name = "motando_csrf-secret-key"    
    description = "Motando CSRF SECRET_KEY"

    vault_id = module.gru_vault.id
    key_id = module.gru_motando-aes-mke.id

    content_type = "BASE64"
    content = data.external.get_secret_key.result.secret_key

    rule_type = "SECRET_EXPIRY_RULE"
    blocked_on_expiry = true

    # 10 dias
    expiry_interval = "P10D"
}