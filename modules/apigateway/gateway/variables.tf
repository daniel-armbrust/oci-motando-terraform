#
# modules/apigateway/gateway/variables.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/apigateway_gateway
#

variable "compartment_id" {
    description = "(Required) (Updatable) The OCID of the compartment in which the resource is created."
    type = string    
}

variable "display_name" {
    description = "(Optional) (Updatable) A user-friendly name."
    type = string
    default = "api-gw"
}

variable "endpoint_type" {
    description = "(Required) Gateway endpoint type (PUBLIC or PRIVATE)."
    type = string
    
    validation {
       condition = can(regex("^(PUBLIC|PRIVATE)$", var.endpoint_type))
       error_message = "The API GATEWAY ENDPOINT TYPE must be PUBLIC or PRIVATE."
    }
}

variable "subnet_id" {
    description = "(Required) The OCID of the subnet in which related resources are created."
    type = string
}

variable "certificate_id" {
    description = "(Optional) (Updatable) The OCID of the certificate."
    type = string
    default = null
}