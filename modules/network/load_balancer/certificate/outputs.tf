#
# modules/network/load_balancer/certificate/outputs.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/load_balancer_certificate
#

output "name" {
    value = oci_load_balancer_certificate.lb_certificate.certificate_name
}