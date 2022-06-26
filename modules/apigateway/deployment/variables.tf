#
# modules/apigateway/deployment/variables.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/apigateway_deployment
#

variable "compartment_id" {
    description = "(Required) (Updatable) The OCID of the compartment in which the resource is created."
    type = string    
}

variable "display_name" {
    description = "(Optional) (Updatable) A user-friendly name."
    type = string
    default = "api-dpp"
}

variable "gateway_id" {
    description = "(Required) The OCID of the API Gateway."
    type = string
}

variable "path_prefix" {
    description = "(Required) A path on which to deploy all routes contained in the API deployment specification."
    type = string
}

variable "stock_responses" {
    description = "(Optional) (Updatable) The body of the stock response from the mock backend."

    type = list(object({
        path = string
        body = string
        http_methods = list(string)
        status_code = string        
        header_name = string
        header_value = string
    }))

    default = null
}

variable "functions_backend" {
    description = "(Optional) (Updatable) Functions deployment."

    type = list(object({
        function_id = string
        path = string
        http_methods = list(string)  
        cors_allowed_origins = list(string)
        cors_allowed_headers = list(string)
        cors_allowed_methods = list(string)
    }))

    default = null
}

variable "filter_response_headers" {
    description = "(Optional) (Updatable) List of Filter HTTP headers as they pass through the gateway."

    type = list(string)
    default = null
}