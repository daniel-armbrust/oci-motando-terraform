#
# modules/kms/secret/variables.tf
# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/vault_secret
#

variable "compartment_id" {
    description = "(Required) (Updatable) The OCID of the compartment where you want to create the secret."
    type = string    
}

variable "name" {
    description = "(Required) A user-friendly name for the secret. Secret names should be unique within a vault."
    type = string    
}

variable "description" {
    description = "(Optional) (Updatable) A brief description of the secret."
    type = string    
}

variable "vault_id" {
    description = "(Required) The OCID of the vault where you want to create the secret."
    type = string    
}

variable "key_id" {
    description = "(Optional) The OCID of the master encryption key that is used to encrypt the secret."
    type = string
}

variable "content_type" {
    description = "(Required) (Updatable) content type."
    type = string    
    default = "BASE64"
}

variable "content" {
    description = "(Optional) (Updatable) The base64-encoded content of the secret."
    type = string        
}

variable "stage" {
    description = "(Optional) (Updatable) The rotation state of the secret content. The default is CURRENT, meaning that the secret is currently in use."
    type = string   

    validation {
       condition = can(regex("^(CURRENT|PENDING)$", var.stage))
       error_message = "The stage of the rule must be: CURRENT or PENDING."
    }        

    default = "CURRENT"
}

variable "rule_type" {
    description = "(Required) (Updatable) The type of rule, which either controls when the secret contents expire or whether they can be reused."
    type = string

    validation {
       condition = can(regex("^(SECRET_EXPIRY_RULE|SECRET_REUSE_RULE)$", var.rule_type))
       error_message = "The type of rule must be: SECRET_EXPIRY_RULE or SECRET_REUSE_RULE."
    }   

    default = "SECRET_EXPIRY_RULE"
}

variable "blocked_on_expiry" {
    description = "(Updatable) A property indicating whether to block retrieval of the secret content, on expiry."
    type = bool
    default = false
}

variable "expiry_interval" {
    description = "(Updatable) A property indicating how long the secret contents will be considered valid, expressed in ISO 8601 format."
    type = string
    default = null    
}

variable "enforced_on_deleted" {
    description = "(Updatable) A property indicating whether the rule is applied even if the secret version with the content you are trying to reuse was deleted."
    type = bool
    default = false
}

