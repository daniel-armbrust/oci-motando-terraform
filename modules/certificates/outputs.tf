#
# modules/certificates/outputs.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/certificates_management_certificate
#

output "id" {
    value = oci_certificates_management_certificate.certificate.id
}