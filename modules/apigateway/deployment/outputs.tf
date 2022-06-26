#
# modules/apigateway/deployment/outputs.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/apigateway_deployment
#

output "id" {
   description = "The OCID of the resource."
   value = join("", oci_apigateway_deployment.stock_response_deployment.*.id, oci_apigateway_deployment.function_deployment.*.id)
}

output "stock_response_id" {
   description = "The OCID of the resource."
   value = join("", oci_apigateway_deployment.stock_response_deployment.*.id)   
}

output "endpoint" {
   description = "The endpoint to access this deployment on the gateway."
   value = join("", oci_apigateway_deployment.stock_response_deployment.*.endpoint, oci_apigateway_deployment.function_deployment.*.endpoint)   
}

output "path_prefix" {
   description = "A path on which to deploy all routes contained in the API deployment specification."
   value =  join("", oci_apigateway_deployment.function_deployment.*.path_prefix)
} 