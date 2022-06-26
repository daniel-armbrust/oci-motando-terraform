#
# modules/apigateway/certificate/outputs.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/apigateway_certificate
#

output "id" {
    value = oci_apigateway_certificate.certificate.id
}