#
# modules/apigateway/certificate/main.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/apigateway_certificate
#

resource "oci_apigateway_certificate" "certificate" {
    compartment_id = var.compartment_id
    display_name = var.display_name

    certificate = var.certificate
    private_key = var.private_key
    intermediate_certificates = var.intermediate_certificates
}