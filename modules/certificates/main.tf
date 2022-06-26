#
# modules/certificates/main.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/certificates_management_certificate
#

resource "oci_certificates_management_certificate" "certificate" {
    compartment_id = var.compartment_id
    name = var.name
    description = var.certificate_description
   
    certificate_config {
        config_type = var.config_type

        certificate_pem = var.certificate
        cert_chain_pem = var.intermediate_certificates        
        private_key_pem = var.private_key
    }    
}