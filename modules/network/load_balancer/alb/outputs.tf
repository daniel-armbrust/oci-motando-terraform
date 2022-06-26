#
# modules/network/load_balancer/alb/outputs.tf
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/load_balancer_load_balancer
#

output "id" {
    value = oci_load_balancer_load_balancer.load_balancer.id
}

output "ip_address" {
    value = join("", oci_load_balancer_load_balancer.load_balancer.ip_address_details.*.ip_address)
}