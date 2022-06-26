#
# modules/apigateway/gateway/main.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/apigateway_gateway
#

resource "oci_apigateway_gateway" "gateway" {    
    compartment_id = var.compartment_id
    display_name = var.display_name
    endpoint_type = var.endpoint_type
    subnet_id = var.subnet_id
    certificate_id = var.certificate_id
}