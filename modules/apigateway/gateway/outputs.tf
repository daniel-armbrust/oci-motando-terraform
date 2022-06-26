#
# modules/apigateway/gateway/outputs.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/apigateway_gateway
#

output "id" {
    value = oci_apigateway_gateway.gateway.id
}

output "hostname" {
    value = oci_apigateway_gateway.gateway.hostname
}

output "ip_address" {
    # TODO: Need to test when the API Gateway returns more than one IP Address.
    value = oci_apigateway_gateway.gateway.ip_addresses[0].ip_address
}