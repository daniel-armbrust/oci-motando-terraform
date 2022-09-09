#
# modules/kms/secret/main.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/vault_secret
#

resource "oci_vault_secret" "secret_expiry_rule" {   
    count = var.rule_type == "SECRET_EXPIRY_RULE" ? 1 : 0

    compartment_id = var.compartment_id
    secret_name = var.name
    description = var.description
    
    secret_content {   
        content_type = var.content_type
        content = var.content
        name = var.name
        stage = var.stage
    }

    vault_id = var.vault_id
    key_id = var.key_id    

    secret_rules {        
        rule_type = var.rule_type        

        secret_version_expiry_interval = var.expiry_interval        
        is_secret_content_retrieval_blocked_on_expiry = var.blocked_on_expiry    
    }
}


resource "oci_vault_secret" "secret_reuse_rule" {   
    count = var.rule_type == "SECRET_REUSE_RULE" ? 1 : 0

    compartment_id = var.compartment_id
    secret_name = var.name
    description = var.description
    
    secret_content {   
        content_type = var.content_type
        content = var.content
        name = var.name
        stage = var.stage
    }

    vault_id = var.vault_id
    key_id = var.key_id    

    secret_rules {        
        rule_type = var.rule_type             

        is_enforced_on_deleted_secret_versions = var.enforced_on_deleted
    }
}